# Weak Reference

An Object that wraps other object. When the object hold by the Weak Reference is GC collected 
then the corresponding Weak Reference is set to NULL

Example

     TestObject testObj = new TestObject();
     WeakReference wr = new WeakReference(testObj);

     // Verify that the WeakReference actually points to the intended object instance.
     assertEquals(wr.get(), testObject);

     // Force disposal of testObj;
     testObj  = null;
     System.gc();            
    // If no strong references are left to the wr.Target, wr.get() will return NULL.
     assertNull(wr.get());

Typical use is WeakHashMap, its key is Weak Reference. When the object hold by the key is no 
longer in use (subject to GC) then the reference hold by the key is set to NULL resulting in 
removing of the (key,value) pair from the WeakHashMap.

    // SampleKey is just an object that holds a single int. (Use instead of
    // Integer, since Integer overrides equals() and hashcode())
    SampleKey key = new SampleKey(42);
    SampleObject value = new SampleObject("Sample Value");
    
    final WeakHashMap<SampleKey, SampleObject> weakHashMap = new WeakHashMap<SampleKey, SampleObject>();
    weakHashMap.put(key, value);
    
    // At this point, we still have a strong reference to the key. Thus, even
    // though the key is weakly-referenced by the WeakHashMap, nothing will
    // be automatically removed even if we give a hint to the GC.
    System.gc();
    
    LOGGER.debug(weakHashMap.size()); // Will still be '1'.
    LOGGER.debug(weakHashMap.get(key)); // Will still be 'Sample Value'.
    
    // Now, we if set the key to null, the entry in weakHashMap will eventually
    // disappear. Note that the number of times we have to 'kick' the GC
    // before the entry disappears may be different on each run depending
    // on the JVM load, memory usage, etc.
    key = null;
    int count = 0;
    while(0 != weakHashMap.size())
    {
      ++count;
      System.gc();
    }
    LOGGER.debug("Took " + count + " calls to System.gc() to result in in weakHashMap size of : " + weakHashMap.size());
