## Flow of calls

Java programs are built on top of JDK, use clasess from JDK,
JDK itself is written mostly in Java plus small part in C, that interface with JVM - Hotspot

* The flow of call: Java Program->JDK Java code ->JDK native code/JNI->Hotspot primitives->Hotspot world in cpp
* sample stack

       "ajp-0.0.0.0-8029-1082" daemon prio=10 tid=0x63721000 nid=0x2cba waiting for monitor entry [0x4e619000]
       java.lang.Thread.State: BLOCKED (on object monitor)
    	    at java.lang.Class.forName0(Native Method)
	    at java.lang.Class.forName(Class.java:186)

## Finding JNI methods in JDK

* jdk class: open-jdk-src/java/lang/Class.java

        private static native Class forName0(String name, boolean initialize,
                                            ClassLoader loader)

* jdk native implementation: icedtea6-1.9.10/openjdk/jdk/src/share/native/java/lang/Class.c 

        JNIEXPORT jclass JNICALL
        Java_java_lang_Class_forName0(JNIEnv *env, jclass this, jstring classname,
                              jboolean initialize, jobject loader)
        {
        ...
           cls = JVM_FindClassFromClassLoader(env, clname, initialize,
                                       loader, JNI_FALSE);
        ...
        }

## Hotspot primitives: 

Hotspot provide a set of primitives that iteraction with JDK

* icedtea6-1.9.10/openjdk/hotspot/src/share/vm/prims/jvm.h
* icedtea6-1.9.10/openjdk/hotspot/src/share/vm/prims/jvm.cpp

        JVM_ENTRY(jclass, JVM_FindClassFromClassLoader(JNIEnv* env, const char* name,
                                                       jboolean init, jobject loader,
                                                       jboolean throwError))
          JVMWrapper3("JVM_FindClassFromClassLoader %s throw %s", name,
                       throwError ? "error" : "exception");
          // Java libraries should ensure that name is never null...
          if (name == NULL || (int)strlen(name) > symbolOopDesc::max_length()) {
            // It's impossible to create this class;  the name cannot fit
            // into the constant pool.
            if (throwError) {
              THROW_MSG_0(vmSymbols::java_lang_NoClassDefFoundError(), name);
            } else {
              THROW_MSG_0(vmSymbols::java_lang_ClassNotFoundException(), name);
            }
          }
          symbolHandle h_name = oopFactory::new_symbol_handle(name, CHECK_NULL);
          Handle h_loader(THREAD, JNIHandles::resolve(loader));
          jclass result = find_class_from_class_loader(env, h_name, init, h_loader,
                                                       Handle(), throwError, THREAD);
        
          if (TraceClassResolution && result != NULL) {
            trace_class_resolution(java_lang_Class::as_klassOop(JNIHandles::resolve_non_null(result)));
          }
          return result;
        JVM_END
        
        jclass find_class_from_class_loader(JNIEnv* env, symbolHandle name, jboolean init, Handle loader, Handle protection_domain, jboolean throwError, TRAPS) {
          // Security Note:
          //   The Java level wrapper will perform the necessary security check allowing
          //   us to pass the NULL as the initiating class loader.
          klassOop klass = SystemDictionary::resolve_or_fail(name, loader, protection_domain, throwError != 0, CHECK_NULL);
        
          KlassHandle klass_handle(THREAD, klass);
          // Check if we should initialize the class
          if (init && klass_handle->oop_is_instance()) {
            klass_handle->initialize(CHECK_NULL);
          }
          return (jclass) JNIHandles::make_local(env, klass_handle->java_mirror());
        }
        
## Hotspot world in CPP

        klassOop SystemDictionary::resolve_or_fail(symbolHandle class_name, Handle class_loader, Handle protection_domain, bool throw_error, TRAPS) {
          klassOop klass = resolve_or_null(class_name, class_loader, protection_domain, THREAD);
          if (HAS_PENDING_EXCEPTION || klass == NULL) {
            KlassHandle k_h(THREAD, klass);
            // can return a null klass
            klass = handle_resolution_exception(class_name, class_loader, protection_domain, throw_error, k_h, THREAD);
          }
          return klass;
        }

