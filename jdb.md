## jdb

This is simple command line debugger. Example of usage

**Start java process with debug agent**

    $java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=localhost:9009 MyClass
    
**Attache debugger to java process**

    $jdb -attach localhost:9009
    
**Add break point**

    >stop in java.lang.String.length
    
**Step in**

    >step 
    
**Step one call level up**

    >step up

**Show local variables**    

    >locals

**Dump object's fields**    

    >dump this

**Continue until next break point**    

    >continue

