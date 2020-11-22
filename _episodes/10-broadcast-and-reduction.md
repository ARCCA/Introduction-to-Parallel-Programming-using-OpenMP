---
title: "Reduction operation"
teaching: 15
exercises: 5
questions:
- "How to use OpenMP reduction directives"
objectives:
- "Use *copyprivate* and *reduction* constructs to communicate data among threads"
keypoints:
- "OpenMP constructs *copyprivate* and *reduction* are useful to pass values obtained by a one or more threads to other threads in the team, and to perform some recurrence calculations in parallel" 
---

## Broadcast and reduction
At the end of a parallel block performing some computation, it is often useful to consolidate the result held by a private variable in each thread into single value, often performing some operation on it in the process.
- **copyprivate** Broadcast a single value to a private variable in each thread
- **reduction** Perform an operation on each threaded private variable and store the result in a global shared variable.

Let us take consider the following example. The serial version of this code simply obtains and prints a value to broadcast (in this case its thread ID number) and then performs a calculation of 2 elevated to the power given by its thread ID number and prints the result.

In parallel, the aim is to keep the section of the code where only one thread obtains the broadcast value, but then communicates it to the other threads in the team. And then, have each thread perform the calculation using its own ID number. At the end of the program we want to print the sum of the individual values calculated by each thread.


> ## Example (serial)
> ~~~
> // Load the OpenMP functions library
> #include<omp.h>
> #include<math.h> //for pow function
> 
> int main()
> {
>   // Set and initialise variables
>   int broad=0, tnum=0, calc=0;
>   broad = omp_get_thread_num();
> 
>   // Print out the broadcast value
>   printf("broad = %d\n", broad);
> 
>   calc = 0;
>   tnum = omp_get_thread_num();
>   calc = pow(2,tnum);
>   printf("Thread number = %d calc = %d\n",tnum, calc);
> 
>   printf("Reduction = %d\n", calc);
> 
>   return 0;
> }
> ~~~
> {: .language-c}
>
{: .callout}


> ## Example (parallel)
> ~~~
> #include<omp.h>
> #include<math.h> //for pow function
> 
> int main()
> {
>    // Set and initialise variables
>    int broad=0, tnum=0, calc=0;
> 
>    // Start parallel block
>    #pragma omp parallel private(broad,tnum,calc)
>    {
>        // We want a single thread to broadcast a value to the entire block of
>        // threads.
>        #pragma omp single copyprivate(broad)
>        {
>            broad = omp_get_thread_num();
>        }
> 
>        // Print out the broadcast value
>        printf("broad = %d\n", broad);
>    }
> 
>    calc = 0;
>    // Each thread in this block will perform a calculation based on its thread
>    // number. These results are then reduced by performing an action on them, in
>    // this case a summation.
>    #pragma omp parallel private(tnum) reduction(+:calc)
>    {
>        tnum = omp_get_thread_num();
>        calc = pow(2,tnum);
>        printf("Thread number = %d calc = %d\n",tnum, calc);
>    }
> 
>    printf("Reduction = %d\n", calc);
> 
>    return 0;
> }
> ~~~
> {: .language-c}
>
{: .solution}


> ## Using broadcast and reduction constructs
> Let us begin by confirming that our code behaves in serial mode in the way we expect. For this you don't need to make any modifications since the OpenMP directives are commented out at the moment. Go ahead and compile the code:
> <pre style="color: silver; background: black;">
> ~/openmp/Intro_to_OpenMP.2019/c$ icc -qopenmp -o reduc reduc.c
> </pre>
>
> Once we are satisfied with the serial version of the code, uncomment the OpenMP directives that create the *parallel* region. Use **broadcast** and **reduction** to achieve the objectives of this exercise. Did you run into any issues?
>
{: .challenge}

## Other reduction constructs
C,C++
- Operators +, -, *, &&, ||,
- Intrinsics max, min

Fortran
- Operators +, -, *, .AND., .OR., .EQV., .NEQV.
- Intrinsics MAX, MIN, IAND, IOR, IEOR

{% include links.md %}
