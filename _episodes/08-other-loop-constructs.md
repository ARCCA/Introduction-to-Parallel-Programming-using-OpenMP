---
title: "OpenMP examples (4)"
teaching: 0
exercises: 0
questions:
- "How to divide a code in sections and assign each section to one thread?"
- "Another way of assigning only one thread to a programs' region"
objectives:
- "Learn to use OpenMP *sections* and *single* constructs to better control how work is divided among threads"
- "Understand the effect of implicit barriers and how to remove them"
keypoints:
- "The OpenMP *sections* construct allow us to divide a code in regions to be executed by individual threads"
- "The OpenMP *single* construct specifies that a code region should only be executed by one thread"
- "Many OpenMP constructs apply an implicit barrier at the end of its defined region. This can be overruled with *nowait* clause. However, this should be done carefully as to avoid data conflicts and race conditions"
---

## Other loop constructs
This time we have a code that have two well defined tasks to perform: 
1) print a thread number
2) print a thread number, the total number of threads available, and the sum of all thread IDs.

In serial mode these tasks will be performed by the only thread available (0). But in parallel we can assign them to one thread each.

We will modify our example to add OpenMP directives that allow us to:
- Create a parallel region to be distributed among available threads
- Create a *sections* block to distribute available blocks to single threads
- Blocks are identified with a *section* directive
 
~~~
// Load the OpenMP functions library
#include<omp.h>

int main()
{
  // Set variables
  int num_threads=0, tnum=0, i=0, total=0;

  // Create parallel block
  //#pragma omp parallel
  //  {

    //Create a section block
  //#pragma omp sections private(tnum, i)  nowait
  //    {

  // Ask an available thread to print out the thread number.
  //#pragma omp section
  //      {
  tnum = omp_get_thread_num();
  printf("I am thread number %d\n", tnum);
  //      }

  // Ask another section to add up the thread numbers
  //#pragma omp section
  //      {
  num_threads = omp_get_num_threads();
  tnum = omp_get_thread_num();
  total = 0;
  for (i=1; i<=num_threads; i++)
    total = total + i;
  printf("thread number %d says total = %d\n", tnum, total);
  //      }

  // Close the section block. Normally this sets a barrier that requires all
  // the threads to have completed processing by this point, but we've
  // bypassed it with the "nowait" argument.
  //    }

  // Print out the fact that the section block has finished. How many threads
  // are still functional at this point?
  printf("Finished sections block\n");


  // We only want one thread to operate here.
  //#pragma omp single
  //    {
  tnum = omp_get_thread_num();
  printf("Single thread = %d\n", tnum);
  //    }

  // End parallel block
  //  }

  return 0;
}
~~~
{: .language-c}

> ## Creating sections
> Let us begin by confirming that our code behaves in serial mode in the way we expect. For this you don't need to make any modifications since the OpenMP directives are commented out at the moment. Go ahead and compile the code:
> <pre style="color: silver; background: black;">
> ~/openmp/Intro_to_OpenMP.2019/c$ icc -qopenmp -o constructs constructs.c
> </pre>
>
> Once we are satisfied with the serial version of the code, uncomment the OpenMP directives that create the *parallel* and *sections* regions. Recompile and run again. How does it behave?
>
{: .challenge}

> ## Single thread
>
> The output of our program looks a bit lengthy due to all threads reaching the last printing command. If we wanted this section to be executed by only one thread we could try using OpenMP directive *single*. Go ahead and uncomment this directive. Recompile and run the program. What is the output this time?
> 
{: .challenge}

> ## Implicit barriers
> 
> Our *sections* OpenMP directive by default creates an implicit barrier at the end of its defined region. In our example we removed it with a *nowait* clause that caused threads to continue executing the program without waiting for all other threads to finish the *sections* region. Several constructs have this behaviour (e.g. *parallel*, *single*)
> ~~~
> #pragma omp sections private(tnum, i) nowait
> ~~~
> {: .language-c}
>
> Try removing the *nowait* clause. Recompile and run the program. How it behaves this time? Can you see the effect of the implicit barrier?
>
{: .challenge}

## Sections
The sections construct is a non-iterative worksharing construct that contains a set of structured blocks that are to be distributed among and executed by the threads in a team. Each structured block is executed once by one of the threads in the team in the context of its implicit task. 

## Single
The single construct specifies that the associated structured block is executed by only one of the threads in the team (not necessarily the master thread), in the context of its implicit task. The other threads in the team, which do not execute the block, wait at an implicit barrier at the end of the single construct unless a nowait clause is specified. 

> ## OpenMP parallelization strategy
> 
> - Start with a correct serial execution of the application 
> - Apply OpenMP directives to time-consuming do loops one at a time and TEST 
> - Keep private variables and race conditions always in mind
> - Use a profiler or debugger in case of strange results or crashes
> - Results should be bit reproducible for different numbers of threads
> - Avoid reductions for reals (except: max, min) 
> - Fortran array syntax supported with WORKSHARE
>
{: .checklist}

## Race conditions
Consider the following example. Where we are looking at estimating a best cost through a computationally expensive function (a random function for the sake of demonstration). We perform a for loop in which we compare with previous obtained costs and if a new minimum is found, the best cost is updated. At the end we print the overall best cost.
~~~
#include<omp.h>
#include<stdlib.h>

int main()
{
    srand (time(NULL));
    int i;
    int N=20;
    int best_cost=RAND_MAX;
    #pragma omp parallel shared(best_cost)
    {
        #pragma omp for nowait
        for (i=0; i<N; i++)
        {
            int tid = omp_get_thread_num();
            int my_cost;
            my_cost = rand() % 100;
            //#pragma omp critical
            printf("tid %i -  %i\n",tid,my_cost);
            if(best_cost > my_cost)
            {
                printf("tid %i says that %i is lower than %i \n",tid,my_cost,best_cost);
                best_cost = my_cost;
            }
        }
     }
     printf("Best cost %d\n",best_cost);
}
~~~
{: .language-c}

> ## Debugging race conditions
>
> Try running in serial mode (compile without *-qopenmp* flag) the example above and analize the ouput.
> <pre style="color: silver; background: black;">
> ~/openmp/Intro_to_OpenMP.2019/c$ icc -o race race.c
> </pre>
>
> Does it work as expected? Try this time adding openmp support to parallelize the for loop:
> <pre style="color: silver; background: black;">
> ~/openmp/Intro_to_OpenMP.2019/c$ icc -qopenmo -o race race.c
> </pre>
>
> What do you notice?
{: .challenge}

### Critical
When ensuring that shared date is accessed only by one thread at a time, you can use the *critical* construct. Try adding the following directive immediately before our if statement:
~~~
#pragma omp critical
{
 ...
}
~~~
{: .language-c}

Compile and run the program again. Does the output changes?

{% include links.md %}
