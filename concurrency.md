# Concurrency

Concurrent programming usually has to deal with the following aspects

* memory visibility : when one thread modify a memory, it may not visible "immediately" to other
thread due to effect of cache, registry and compiler optimization
* atomicity : when one thread modify a memory, other thread may see "incomplete" modification because
the modification may not be not atomic in the sense of "all" or "nothing".
* ordering : the compiler optimization may change order of instructions thinking that the semantic 
of the code is unchanged.  However it is only true in the context of single thread. So other thread 
may see value of different memory location begin changed in different order of what is in source code.

**Volatile**

To make one thread see modification of other thread, then the field must be
declared as volatile. Read and write to volatile field will generate instruction
to ensure cache coherence and "happen before"/"happen after" ordering.

**CAS**

CAS is supported in JAVA by using relevant CAS instruction of CPU, which means atomicity is guaranteed.

java.util.concurrent.atomic provides classes that support CAS - Compare and Swap
atomic operation. These classes are of primitive types e.g. long, int, reference. 

The implementation is backed by volatile field and uses Java Unsafe for direct memory access.

**Lock free algorithm**

An lock free algorithm use CAS to modify shared data structure while preserving its invariant. 
Each success CAS operation must be a transition of shared data structure from one valid state to other.

Test the correctness in concurrent environment is hard because it is not possible to mimic the behavior 
of multi threads running concurrently. The most useful method to prove correctness is to list all possible
valid states of the shared data structure and prove that employed CAS operations only change from one
valid state to other.

**References**

* http://www.infoq.com/articles/memory_barriers_jvm_concurrency
