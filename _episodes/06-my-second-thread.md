---
title: "Basic thread control"
teaching: 10
exercises: 5
questions:
- "How to obtain OpenMP threads' IDs?"
- "What is the *barrier* OpenMP construct?"
- "What is the *master* OpenMP construct?"
objectives:
- "Learn how to identify OpenMP treads by using IDs"
- "Familiarize with OpenMP *barrier* and *master* constructs and their use"
keypoints:
- "OpenMP threads can be identified by querying their ID using OpenMP functions"
- "OpenMP *barrier* construct allow us to define a point that all threads need to reach before continuing the program execution"
- "OpenMP *master* construct allow us to define regions of the code that should only be executed by the master thread "
---

## Hello World with OpenMP
In this example we will create a simple OpenMP program that does the following:
- Creates a parallel region
- Each thread in the parallel region obtains and prints its unique thread along with a "Hello World" message
- Only the master will print the total number of threads
 
~~~
// Load the OpenMP functions library
#include<omp.h>

int main()
  {
    int nthreads, tid;
    // Fork a team of threads, with private versions of the declared variables.
    // #pragma omp parallel private(nthreads, tid)
    // {
    // Get the thread number and print it
    tid = omp_get_thread_num();
    printf("Hello World from thread number %d\n", tid);

    // Only the master thread does the following
    // #pragma omp barrier
    // #pragma omp master
    // {
    if (tid == 0)
      {
        nthreads = omp_get_num_threads();
        printf("Number of threads = %d\n", nthreads);
      }
    // }

    // End of pragma, disband all but the master thread
    //}
    return 0;
  }
~~~
{: .language-c}

> ## From serial to parallel.
> The first thing to notice in the example above is the commented lines that include the OpenMP directives. As it stands, this program will work in serial mode. Go ahead and compile it:
> <pre style="color: silver; background: black;">
> ~/openmp/Intro_to_OpenMP.2019/c$ icc -qopenmp -o hello hello.c
> </pre>
>
> What is the output when you run it. What happens if you remove the compiler flag *-qopenmp*?
>
> As you have noticed, in the program we are making use of a couple of OpenMP routines to identify the threads' unique ID numbers and the maximum threads available. Without the flag *-qopenmp* the compiler doesn't understand these functions and therefor throws an error.
>
> Try uncommenting lines 8,9 and 26. Recompile and run the program. What happens in this case? Why?
>
{: .challenge}

By adding a few lines we were able to define a region in our code to be distributed among threads. In this region we are defining as *private* two variables *nthreads* and *tid* so that each thread will have their own copies.
~~~
 #pragma omp parallel private(nthreads, tid)
 {
  ...
 }
~~~
{: .language-c}

## Barriers
The barrier construct specifies an explicit barrier at the point at which the construct appears. The barrier construct is a stand-alone directive. It defines a point in the code where threads will stop and wait for all other threads to reach that point. This is a way to guarantee calculations performed up to that point have been completed.

> ## Using barriers
>
> Continuing with the above example. We noticed that all threads print their ID number and master prints additionally the total number of threads. However, we can not predict at which point we will obtain the total number. If we wanted to make sure to print the total number of threads in the very last line, we could a barrier. 
>
> Try uncommenting line 15 in the code. Recompile and run the program. What happens this time?
>
{: .challenge}

## Master
So far in our example we have been using a conditional *if* statement to obtain and print the total number of threads, since we know the master thread ID is 0. However, OpenMP gave us a *master* construct that allow us to specify that a structured block to only be executed by the master thread of a team.

> ## Using the master
>
> Keep working in our hello world example. Uncomment line 16 and comment out line 18. Were there any changes?
>
{: .challenge}

{% include links.md %}
