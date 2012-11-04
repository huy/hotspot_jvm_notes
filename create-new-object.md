# How new object is created

**byte code**

create a simple java and corresponding byte code

    public class Bar {
      public static Bar create() {
        return new Bar();
      }
    }

    public static Bar create();
      Code:
       Stack=2, Locals=0, Args_size=0
       0:	new	#2; //class Bar
       3:	dup
       4:	invokespecial	#3; //Method "<init>":()V
       7:	areturn
      LineNumberTable: 
       line 3: 0
    
    
    }

**JVM intepreter of byte code**

`src/share/vm/interpreter/bytecodes.cpp`

    void Bytecodes::initialize() {
    ...
        def(_invokedynamic       , "invokedynamic"       , "bJJJJ", NULL    , T_ILLEGAL,  0, true );
        def(_new                 , "new"                 , "bkk"  , NULL    , T_OBJECT ,  1, true );


The fast allocation use TLAB `src/share/vm/interpreter/bytecodeInterpreter.cpp`

   BytecodeInterpreter::run(interpreterState istate) {
   ...
   
         CASE(_new): {
        u2 index = Bytes::get_Java_u2(pc+1);
        ConstantPool* constants = istate->method()->constants();
        if (!constants->tag_at(index).is_unresolved_klass()) {
          // Make sure klass is initialized and doesn't have a finalizer
          Klass* entry = constants->slot_at(index).get_klass();
          assert(entry->is_klass(), "Should be resolved klass");
          Klass* k_entry = (Klass*) entry;
          assert(k_entry->oop_is_instance(), "Should be InstanceKlass");
          InstanceKlass* ik = (InstanceKlass*) k_entry;
          if ( ik->is_initialized() && ik->can_be_fastpath_allocated() ) {
            size_t obj_size = ik->size_helper();
            oop result = NULL;
            // If the TLAB isn't pre-zeroed then we'll have to do it
            bool need_zero = !ZeroTLAB;
            if (UseTLAB) {
              result = (oop) THREAD->tlab().allocate(obj_size);
            }
            if (result == NULL) {
              need_zero = true;
              // Try allocate in shared eden
        retry:
              HeapWord* compare_to = *Universe::heap()->top_addr();
              HeapWord* new_top = compare_to + obj_size;
              if (new_top <= *Universe::heap()->end_addr()) {
                if (Atomic::cmpxchg_ptr(new_top, Universe::heap()->top_addr(), compare_to) != compare_to) {
                  goto retry;
                }
                result = (oop) compare_to;
              }
            }
            if (result != NULL) {
              // Initialize object (if nonzero size and need) and then the header
              if (need_zero ) {
                HeapWord* to_zero = (HeapWord*) result + sizeof(oopDesc) / oopSize;
                obj_size -= sizeof(oopDesc) / oopSize;
                if (obj_size > 0 ) {
                  memset(to_zero, 0, obj_size * HeapWordSize);
                }
              }
              if (UseBiasedLocking) {
                result->set_mark(ik->prototype_header());
              } else {
                result->set_mark(markOopDesc::prototype());
              }
              result->set_klass_gap(0);
              result->set_klass(k_entry);
              SET_STACK_OBJECT(result, 0);
              UPDATE_PC_AND_TOS_AND_CONTINUE(3, 1);
            }
          }
        }
        // Slow case allocation
        CALL_VM(InterpreterRuntime::_new(THREAD, METHOD->constants(), index),
                handle_exception);
        SET_STACK_OBJECT(THREAD->vm_result(), 0);
        THREAD->set_vm_result(NULL);
        UPDATE_PC_AND_TOS_AND_CONTINUE(3, 1);
      }


The slow case allocation `src/share/vm/interpreter/interpreterRuntime.cpp` 


    IRT_ENTRY(void, InterpreterRuntime::_new(JavaThread* thread, ConstantPool* pool, int index))
      Klass* k_oop = pool->klass_at(index, CHECK);
      instanceKlassHandle klass (THREAD, k_oop);
    
      // Make sure we are not instantiating an abstract klass
      klass->check_valid_for_instantiation(true, CHECK);
    
      // Make sure klass is initialized
      klass->initialize(CHECK);
    
      // At this point the class may not be fully initialized
      // because of recursive initialization. If it is fully
      // initialized & has_finalized is not set, we rewrite
      // it into its fast version (Note: no locking is needed
      // here since this is an atomic byte write and can be
      // done more than once).
      //
      // Note: In case of classes with has_finalized we don't
      //       rewrite since that saves us an extra check in
      //       the fast version which then would call the
      //       slow version anyway (and do a call back into
      //       Java).
      //       If we have a breakpoint, then we don't rewrite
      //       because the _breakpoint bytecode would be lost.
      oop obj = klass->allocate_instance(CHECK);
      thread->set_vm_result(obj);
    IRT_END

