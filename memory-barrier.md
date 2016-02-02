## Memory barrier

### what is it ?

Modern multi cores CPU has different level of cache as such write to memory location by one core is not immediately visible 
to an other. We can imagine that each core has both read buffer and write buffer to read from and write to. These buffers 
need to be flushed in order to make the change the an variable by one to be seen by an other.

Memory barrier is CPU instructions that flush the read/write buffer cache. On Intel CPU,  there are basically two kind of barriers 

* write barrier
* load barrier  

The write barrier running on a core flushes write cache of the core. The read barrier conversely flushes the core read cache. 
Suppose that we modify an variable in one core and want that update to be seen by an other core then on the first core we 
need to execute write barrier instruction after the modification (to flush the core write buffer) and also issue the read 
barrier instruction before reading the variable on the other core (to drain the other core read buffer). 

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
       

### How a memory barrier is used Java ?

The simplest usecase is variable declared as `volatile`. Whenever we modify a volatile variable then java inserts a `write_barrier` instruction after the modification instruction, conversely when we read a volatile variable java it 
inserts `read_barrier` before the instruction the load the variable.


