---
title: "Synchronization"
teaching: 10
exercises: 5
questions:
- "How to use OpenMP synchronization directives"
objectives:
- "Use *master*, *barrier* and *critical* constructs to better control our threads are synchronized"
keypoints:
- "OpenMP constructs *master*, *barrier* and *critical* are useful to define sections and points in our code where threads should synchronize with each other" 
---

## Synchronization
As we have seen previously, sometimes we need to force a thread to ‘lock-out’ other threads for a period of time when operating on shared variables, or wait until other threads have caught up to ensure that a calculation has been completed before continuing. OpenMP directives useful for this purpose are:
- **MASTER** Only the master thread will execute this code
- **SINGLE** Only one thread will execute this code
- **CRITICAL** Threads must execute code one at a time
- **BARRIER** Waits until all threads reach this point

Let us take a look at the following example. In this case, the serial version of this code simply increments a counter by 1, prints the thread ID number, waits for 10 seconds and confirms that the program finished.

We might want to rewrite this code to work in parallel. Perhaps our counter is keeping track of how many threads have finished successfully, or perhaps it represents a line in a text file where every entry is the name of a data file that needs to be processed. In any case, we might want to ensure that it is updated carefully.

> ## Example (serial)
> ~~~
> // Load the OpenMP functions library
> #include<omp.h>
> 
> int main()
> {
>   // Set and initialise variables
>   int tnum=0, incr=0;
> 
>     // Start a critical block that we want only one thread to access
>     // at a time. Note that the 'incr' variable is NOT private!
>       incr = incr + 1;
> 
>     // The master thread prints out the results of the calculation and
>     // then does some other processing that the other threads have to
>     // wait for.
>       tnum = omp_get_thread_num();
>       printf("Master thread is number %d\n", tnum);
>       printf("Summation = %d\n", incr);
>       sleep (10);
> 
>     // Ensure ALL threads have finished their processing before continuing.
>       printf("finished!\n");
> 
>   return 0;
> }
> ~~~
> {: .language-c}
>
{: .callout}


> ## Example (parallel)
> ~~~
> // Load the OpenMP functions library
> #include<omp.h>
> 
> int main()
> {
>    // Set and initialise variables
>    int tnum=0, incr=0;
> 
>    // Start parallel block
>    #pragma omp parallel private(tnum)
>    {
>        // Start a critical block that we want only one thread to access
>        // at a time. Note that the 'incr' variable is NOT private!
>        #pragma omp critical
>        {
>            incr = incr + 1;
>        }
> 
>        // The master thread prints out the results of the calculation and
>        // then does some other processing that the other threads have to
>        // wait for.
>        #pragma omp master
>        {
>            tnum = omp_get_thread_num();
>            printf("Master thread is number %d\n", tnum);
>            printf("Summation = %d\n", incr);
>            sleep (10);
>        }
> 
>        // Ensure ALL threads have finished their processing before continuing.
>        #pragma omp barrier
>        {
>            printf("finished!\n");
>        }
>    }
> 
>    return 0;
> }
> ~~~
> {: .language-c}
>
{: .solution}


> ## More race conditions
> Let us begin by confirming that our code behaves in serial mode in the way we expect. For this you don't need to make any modifications since the OpenMP directives are commented out at the moment. Go ahead and compile the code:
> <pre style="color: silver; background: black;">
> ~/openmp/Intro_to_OpenMP.2019/c$ icc -qopenmp -o sync sync.c
> </pre>
>
> Once we are satisfied with the serial version of the code, uncomment the OpenMP directives that create the *parallel* region. Recompile and run again. How does it behave? How can it be improved?
>
{: .challenge}

{% include links.md %}
