## Memory barrier

Modern multi cores CPU has different level of cache as such write to memory location by one core is not immediately visible 
to an other. We can imagine that each core has both read buffer and write buffer to read from and write to. These buffers 
need to be flushed in order to make the change the an variable by one to be seen by an other.

Memory barrier is CPU instructions that flush the read/write buffer cache. On Intel CPU,  there are basically two kind of barriers 

* write barrier and 
* load barrier.  

The write barrier running on a core flushes write cache of the core. The read barrier conversely flushes the core read cache. 
Suppose that we modify an variable in one core and want that update to be seen by an other core then on the first core we 
need to execute write barrier instruction after the modification (to flush the core write buffer) and also issue the read 
barrier instruction before reading the variable on the other core. 

    Core 1
    ------
    a := 9
    write_barrier

    Core 2
    ------
    while (true) {
       load_barrier
       if (a == 9)
        break;
    }
       
