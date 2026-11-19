---
title: "Setting number of threads"
teaching: 10
exercises: 5
questions:
- "How to control the number of threads created by OpenMP?"
objectives:
- "Learn to control the number of OpenMP number threads by environment
   variable and programmatically"
keypoints:
- "We can use the environment variable OMP_NUM_THREADS to control how
   many threads are created by OpenMP by default"
- "OpenMP function *num_threads* have a similar effect and can be used
   within your code"
---

## Setting the number of threads
In our previous "Hello World" example we noticed that OpenMP created as
many threads as CPUs available on your machine (or SLURM session). This
is the default behaviour of the `parallel` construct.

This behaviour can be modified globally by defining an environment
variable. Setting it, for example, to 8 threads:
~~~
export OMP_NUM_THREADS=8
~~~
{: .language-bash}

…or dynamically from within your code:

If using Fortran:
~~~
!$OMP PARALLEL NUM_THREADS(8)
~~~
{: .language-fortran}

or the default value using the function
~~~
omp_set_num_threads(8)
~~~
{: .language-fortran}

If using C,C++:
~~~
#pragma omp parallel private(tnum) num_threads(8)
~~~
{: .language-c}

or the default value using the function
~~~
omp_set_num_threads(8)
~~~
{: .language-c}

In this example we will create a simple OpenMP program that does the
following:
- Creates a first parallel region with a defined number of threads.
- Each thread in the first parallel region obtains and prints its
  unique thread number.
- Creates a second parallel region without specifying the number
  of threads.
- Each thread in the second parallel region obtains and prints its
  unique thread number.
- Only the master will print the total number of threads.
 
~~~
// setthreads.c
// Load the OpenMP functions library
#include<omp.h>
#include <stdio.h>

int main()
{
  // Set variables
  int tnum=0;

  // Create a parallel block of four threads (including master thread)
/* #pragma omp parallel private(tnum) num_threads(4) */
/*   {     */
    tnum = omp_get_thread_num();
    printf("I am thread number: %d\n", tnum);
  /* } */

  // Create a parallel block, without specifying the number of threads
/* #pragma omp parallel private(tnum) */
/*   {     */
    tnum = omp_get_thread_num();
    printf("Second block, I am thread number %d\n", tnum);
  /* } */

  return 0;
}
~~~
{: .language-c}

> ## Controlling the number of threads.
> Let us begin by confirming that our code behaves in serial mode in the
> way we expect. For this you don't need to make any modifications since
> the OpenMP directives are commented out at the moment. Go ahead and
> compile the code:
> <pre style="color: silver; background: black;">
> ~/arc_openmp/c$ gcc -fopenmp -o setthreads setthreads.c
> </pre>
>
> Once we are satisfied with the serial version of the code, uncomment
> the OpenMP directives. Compile and run again. How does it behave? Try
> modifying the number of threads given to `num_threads`.
>
{: .challenge}

> ## Using environment variables
>
> This time try using the environment variable `OMP_NUM_THREADS` to
> control the number of threads that OpenMP creates by default. To do
> this, type in your command line:
> <pre style="color: silver; background: black;">
> export OMP_NUM_THREADS=4
> </pre>
> 
> And run the program again (notice that no compilation is needed this
> time). What happens?
>
{: .challenge}

{% include links.md %}
