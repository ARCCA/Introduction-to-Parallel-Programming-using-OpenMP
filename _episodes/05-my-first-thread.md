---
title: "My First Thread"
teaching: 20
exercises: 10
questions:
- "How to use OpenMP in C and Fortran?"
- "OpenMP parallel and loop constructs"
objectives:
- "Identify libraries that enable OpenMP functions"
- "Identify compiler flags to enable OpenMP support"
- "Familiarize with OpenMP main constructs"
keypoints:
- "Importing `omp.h` in C,C++, `omp_lib` in Fortran 90 and `omp_lib.h` in Fortran 77 allows OpenMP functions to be used in your code"
- "OpenMP construct *parallel* in C,C++ and *PARALLEL* instructs the compiler to create a team of threads to distribute the region of the code enclosed by the construct"


---

## Setting up
In principle, the exercises on this training lessons can be done on any computer with a compiler that supports OpenMP, but they have been tested on Cardiff University Linux-based supercomputer "Hawk" using Intel compilers 2017.

Access to the system is necessary to undertake this course. It is assumed that attendees have a user account or have received a guest training account.

Please follow the instructions below to obtain some example scripts:

1. Download [arc_openmp.zip][zip-file] and extract somewhere on Hawk. 
2. Extract the zip file and check the extracted directory

For example:

~~~
$ wget {{ site.url }}{{ site.baseurl }}/data/arc_openmp.zip
$ unzip arc_openmp.zip
$ ls arc_openmp
~~~
{: .language-bash}

A node reservation is created in partition c_compute_mdi1. To access it users need to specify in their job scripts:
~~~
#SBATCH --reservation=training
#SBATCH --account=scw1148
~~~
{: .language-bash}


## Using OpenMP
In order to use them, OpenMP function prototypes and types need to be included in our source code by importing a header fileomp.h (for C,C++), a module omp_lib (for Fortran 90) or a file named omp_lib.h (for Fortran 77).

> ## Include OpenMP in your program
>
>
> When using OpenMP in Fortran 77:
> ~~~
> INCLUDE "omp_lib.h"
> ~~~
> {: .language-fortran}
>
> Declare functions at start of code e.g. 
> ~~~
> INTEGER OMP_GET_NUM_THREADS
> ~~~
> {:language-fortran}
>
> When using Fortran 90:
> ~~~
> USE omp_lib
> ~~~
> {: .language-fortran}
>
> When using C or C++:
> ~~~
> #include<omp.h>
> ~~~
> {: .language-c}
> 
{: .callout}

In order to enables the creation of multi-threaded code based on OpenMP directives, we need to pass compilation flags to our compiler:

> ## Compiling OpenMP programs
>
> For Fortran codes:
> <pre style="color: silver; background: black;">
> ~/openmp/Intro_to_OpenMP.2020/fortran$ ifort –qopenmp –o first first.f90
> </pre>
>
> For C codes:
> <pre style="color: silver; background: black;">
> ~/openmp/Intro_to_OpenMP.2020/c$ icc –qopenmp –o first first.c
> </pre>
>
{: .callout}

## My first thread

In this first example we will take a look at how to use OpenMP directives to parallelize sections of our code. But before been able to compile, we need a compiler with OpenMP support. Hawk provides several options but for this training course we will use Intel compilers 2017:
<pre style="color: silver; background: black;">
~$ module load compiler/intel/2017/7
</pre>

Our first example looks like this (there is an equivalent Fortran code too available to you): 

~~~
int main()
  {
    const int N = 10;
    int i;

    #pragma omp parallel for
    for(i = 0; i < N; i++)
    {
        printf("I am counter %d\n", i);
    }
  }
~~~
{: .language-c}

**#pragma** (and  **!$OMP** in the Fortran version) is an OpenMP directive that indicates to the compiler that the following section (a for loop in this case) needs to be parallelized. In C and C++ the parallel section is delimited by loop's scope while in Fortran it needs to be explicitly marked with **!$OMP END**. 

> ## Random threads 
>
> - Try running the program above. What do you notice?
> - Run it a number of times, what happens?
> - What happens if you compile it without the –qopenmp argument?
>
{: .challenge}

## The PARALLEL construct

This is the fundamental OpenMP construct for threading operations that defines a parallel region. When a thread encounters a *parallel* construct, a team of threads is created to execute the parallel region. The thread that encountered the parallel construct becomes the master thread of the new team, with a thread number of zero for the duration of the new parallel region. All threads in the new team, including the master thread, execute the region. The syntax of the *parallel* construct is as follows:  

Fortran:
~~~
!$OMP PARALLEL [clause,[clause...]] 
    block 
!$OMP END PARALLEL 
~~~
{: .language-fortran}

C, C++:
~~~
#pragma parallel omp [clause,[clause...]]
{ 
    block 
}
~~~
{: .language-c}

### Clauses
OpenMP is a shared memory programming model where most variables are visible to all threads by default. However, private variables are necessary sometimes to avoid race conditions and to pass values between the sequential part and the parallel region. Clauses are a data sharing attributes that allow data environment management by appending them to OpenMP directives

For example, a `private` clause declares variables to be private to each thread in a team. Private copies of the variable are initialized from the original object when entering the parallel region. A `shared` clause specifically shares variables among all the threads in a team, this is the default behaviour. A full list of clauses can be found in [OpenMP documentation](https://www.openmp.org/spec-html/5.0/openmpse14.html).

## Loop constructs


The DO (Fortran) directive splits the following do loop across multiple threads.
~~~
!$OMP DO [clause,[clause...]] 
    do_loop 
!$OMP END DO
~~~
{: .language-fortran}


Similarly, the “for” (C) directive splits the following do loop across multiple threads. Notice that no curly brackets are needed in this case.
~~~
#pragma omp for [clause,[clause...]] 
    for_loop 
~~~
{: .language-c}

OpenMP clauses can also define how the loop iterations run across threads. They include:

*SCHEDULE*: How many chunks of the loop are allocated per thread.

Possible options are:

 - `schedule(static, chunk-size)` : Gives threads chunks of size `chunk-size` in circular order around thread id.
   `chunk-size` is optional, default is to divide up work to give one chunk to each thread.
 - `schedule(dynamic, chunk-size)` : Gives threads chunks of size `chunk-size` and when complete gives another chunk
   until complete.  `chunk-size` is optional, default is 1.
 - `schedule(guided, chunk-size)` : Minimum size given by `chunk-size` but size of chunk initially is given by
   unassigned iterations divided by number of threads.
 - `schedule(auto)` : Decision is given to the compiler of runtime.

Auto schedule can be set with `OMP_SCHEDULE` at runtime or `omp_set_schedule` in the code at compile time.

If no *SCHEDULE* is given then compiler dependent default is used.

*ORDERED*: Loop will be executed as it would in serial, i.e. in order.
These clauses are useful when trying to fine-tune the behaviour of our code, but caution should be observed since they can introduced unwanted communication overheads.


> ## Working with private variables and loop constructs
>
> Consider the previous example. What happens if you remove the *for* (*DO*) clause in our OpenMP construct? Is this what you expected?
> What happens if you add the *private(i)* (*DO(i)*) clause? How does the output changes? Why?
>
{: .challenge}

## WORKSHARE

The *WORKSHARE* construct is a Fortran feature that consists of a region with a single structure block (section of code). Statements in the work share region are divided into units of work and executed (once) by threads of the team. A good example for block would be array assignment statements (I.e. no DO)

~~~
!$OMP WORKSHARE 
    block 
!$OMP END WORKSHARE 
~~~
{: .language-fortran}

## Thread creation

Creating OpenMP threads add an overhead to the program's overall runtime and for small loops this can be expensive enough that it doesn't make sense to parallelize that section of the code. If there are several sections of code that require threading, it is better to parallelize the entire program and specify where the workload should be distributed among the threads team.

~~~
#pragma omp parallel for ... 
for (int i=0; i<k; i++)
    nwork1... 
 
#pragma omp parallel for ... for (int i=0; i<k; i++)
    nwor2...
~~~
{: .language-c}

Is better to:
~~~
#pragma omp parallel ...
{
    #pragma omp for ... 
    for (int i=0; i<k; i++)
        nwork1... 

    #pragma omp for ... 
    for (int i=0; i<k; i++)
        nwork2... 
}
~~~
{: .language-c}

[zip-file]: {{ page.root }}/data/arc_openmp.zip


{% include links.md %}
