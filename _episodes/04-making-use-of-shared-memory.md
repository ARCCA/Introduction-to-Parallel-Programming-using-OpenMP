---
title: "Using shared memory"
teaching: 15
exercises: 5
questions:
- "What is OpenMP?"
- "How does it work?"
objectives:
- "Obtain a general view of OpenMP history"
- "Understand how OpenMP help parallelize programs"
keypoints:
- "OpenMP is an API that defines directives to parallelize programs written in Fortran, C and C++"
- "OpenMP relies on directives called pragmas to define sections of code to work in parallel by distributing it on threads."
---

## Brief history

<a href="{{ page.root }}/fig/OpenMP-history.png" target="new">
  <img src="{{ page.root }}/fig/OpenMP-history.png" alt="OpenMP-history" width="40%" height="40%">
</a>

You can consult the original in [Intel's Parallel Universe magazine](https://software.intel.com/sites/default/files/managed/6a/78/parallel_mag_issue18.pdf).

In 2018 OpenMP 5.0 was released, current latest version is OpenMP 5.1 released November 2020.

## What is OpenMP
The OpenMP Application Program Interface (OpenMP API) is a collection of compiler directives, library routines, and environment variables that collectively define parallelism in C, C++ and Fortran programs and is portable across architectures from different vendors. Compilers from numerous vendors support the OpenMP API. See [http://www.openmp.org](http://www.openmp.org) for info, specifications, and support. 


> ## OpenMP in Hawk
>
> Different compilers can support different versions of OpenMP. You can check compatibility by extracting the value of the _OPENMP macro name that is defined to have the decimal value *yyyymm* where *yyyy* and *mm* are the year and month designations of the version of the OpenMP API that the implementation supports. For example, using GNU compilers in Hawk:
> 
> <pre style="color: silver; background: black;">
> ~$ module load compiler/gnu/9/2.0
> ~$  echo | cpp -fopenmp -dM | grep -i open
> #define _OPENMP 201511
> </pre>
> Which indicates that GNU 9.2.0 compilers support OpenMP 4.5 (released on November 2015). Other possible versions are:
> <table>
>  <tr>
>   <th>GCC version</th>
>   <th>OpenMP version</th>
>  </tr>
>  <tr>
>   <td>4.8.5</td>
>   <td>3.1</td>
>  </tr>
>  <tr>
>   <td>5.5.0</td>
>   <td>4.0</td>
>  </tr>
>  <tr>
>   <td>6.4.0</td>
>   <td>4.5</td>
>  </tr>
>  <tr>
>   <td>7.3.0</td>
>   <td>4.5</td>
>  </tr>
>  <tr>
>   <td>8.1.0</td>
>   <td>4.5</td>
>  </tr>
>  <tr>
>   <td>9.2.0</td>
>   <td>4.5</td>
>  </tr>
> </table>
{: .callout}

## OpenMP overview
- OpenMP main strength is its relatively easiness to implement requiring minimal modifications to the source code that automates a lot of the parallelization work.

- The way OpenMP shares data among parallel threads is by creating shared variables.

- If unintended, data sharing can create race conditions. Typical symptom: change in program outcome as threads are scheduled differently.

- Synchronization can help to control race conditions but is expensive and is better to change how data is accessed.

- OpenMP is limited to shared memory since it cannot communicate across nodes like MPI.

## How does it work?
Every code has serial and (hopefully) parallel sections. It is the job of the programmer to identify the latter and decide how best to implement parallelization. Using OpenMP this is achieved by using special directives (**#pragma**)s that mark sections of the code to be distributed among threads. There is a master thread and several slave threads. The latter execute the parallelized section of the code independently and report back to the master thread. When all threads have finished, the master can continue with the program execution.
OpenMP directives allow programmers to specify:
- the parallel regions in a code
- how to parallelize loops
- variable scope
- thread synchronization
- distribution of work among threads

<img src="{{ page.root }}/fig/how_it_works.svg" alt="How it works?" width="50%" height="50%" />

Fortran:
~~~
!$OMP PARALLEL DO PRIVATE(i)
DO i=1,n
  PRINT *, "I am counter i = ", i
ENDDO
!$OMP END PARALLEL DO
~~~
{: .language-fortran}


C:
~~~
#pragma omp parallel for
for (i=0; i < N; i++)
  printf("I am counter %d\n", i);
~~~
{: .language-c++}

## Further reading

[https://www.openmp.org/resources/openmp-compilers-tools/](https://www.openmp.org/resources/openmp-compilers-tools/)

Very comprehensive tutorial:

[https://computing.llnl.gov/tutorials/openMP](https://computing.llnl.gov/tutorials/openMP)

{% include links.md %}
