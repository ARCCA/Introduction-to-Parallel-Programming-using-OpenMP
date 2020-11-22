---
title: "Shared vs Distributed Memory"
teaching: 15
exercises: 0
questions:
- "What is shared memory?"
- "What is distributed memory?"
objectives:
- "Understand the differences between shared and distributed memory"
- "How data is managed by processors in shared and distributed memory systems"
- "Awareness of key performance points when working with parallel programs: granularity and load balancing."
keypoints:
- "Shared memory is the physical memory shared by all CPUs in a multi-processor computer"
- "Distributed memory is the system created by linking the shared memories of different computers"
- "It is important to distribute workload as equally as possible among processors to increase performance"
---

## Shared memory
<figure>
  <img src="{{ page.root }}/fig/shared_memory.svg" alt="Shared memory" width="40%" height="40%" />
</figure>
As the name suggests, shared memory is a kind of physical memory that can be accessed by all the processors in a multi CPU computer. This allows multiple processors to work independently sharing the same memory resources with any changes made by one processor being visible to all other processors in the computer. 

OpenMP is an API (Application Programming Interface) that allows shared memory to be easily programmed. With OpenMP we can split the work of the calculation by dividing the work up among available processors. However, we need to be careful as to how memory is accessed to avoid potential race conditions (e.g. one processor changing a memory location before another has finished reading it).

## Distributed memory
<figure>
  <img src="{{ page.root }}/fig/distributed_memory.svg" alt="Distributed memory" width="40%" height="40%" />
</figure>

In comparison with shared memory systems, distributed memory systems require network communication to connect memory resources in independent computers. In this model each processor runs its own copy of the program and only has direct access to its private data which is typically a subset of the global data. If the program requires data to be communicated across processes this is handled by a *Message Passing Interface* in which, for example, one processor sends a message to another processor to let it know it requires data in its domain. This requires a synchronization step to allow all processors send and receive messages and to prepare data accordingly.

## How it works?
A typical application is to parallelize matrix and vector operations. Consider the following example in which a loop is used to perform vector addition and multiplication. This loop can be easily split across two or more processors since each iteration is independent of the others.

~~~
DO i = 1, size
  E(i) = A(i) + B(i)
  F(i) = C(i)*D(i)
END DO
~~~
{: .language-fortran}

Consider the following figure. In a shared memory system all processors have access to a vector's elements and any modifications are readily available to all other processors, while in a distributed memory system, a vector elements would be decomposed (*data parallelism*). Each processor can handle a subset of the overall vector data. If there are no dependencies as in the previous example, parallelization is straightforward. Careful consideration is required to solve any dependencies, e.g. A(i) = B(i-1) + B (i+1).

<figure>
  <img src="{{ page.root }}/fig/distributed_memory_2.svg" alt="Distributed memory array" width="60%" height="60%" />
</figure>

## The balancing act
In practice, highly optimized software tends to use a mixture of distributed and shared memory parallelism called “hybrid” where the application processes use shared memory within the node and distributed memory across the network.

The challenge is to balance the load across the nodes and processors giving enough work to everyone. The aim is to keep all tasks busy all the time since an idle processor is a waste of resources.

Load imbalances can be caused, for example:
- by array dimensions not being equally divided. Compilers can address these issues through optimization flags, that allow, for example, to collapse loops, changing a matrix A(m,n) to a vector A(n*m) that is easier to distribute.
- Different calculations for different points – e.g. different governing equations applied to sea or land points on a weather forecasting model.
- The amount of work each processor need to do cannot be predicted - e.g. in adaptive grid methods where some tasks may need to refine or coarse their mesh and others don't.

## Granularity
Granularity refers in parallel computing to the ratio between communication and computation, periods of computation are separated by periods of communication (e.g. synchronization events).

There are two types of approaches when dealing with load balancing and granularity parallelization:
- “Fine-grain” - where many small workloads are done between communication events. Small chunks of work are easier to distribute and thus help with load-balancing, but the relatively high number of communication events cause an overhead that gets worse as number of processors increase.

- “Coarse-grain” - where large chunks of workload are performed between communications. It is more difficult to load-balance but reduces the communication overhead

Which is best depend on the type of problem (algorithm) and hardware specifications but in general a "Coarse-grain" approach due to its relatively low communication overhead is considered to have the best scalability.

> ## Steps to parallel code
>
> - Familiarize with the code and identify parts which can be parallelized
>   - This typically requires high degree of understanding
> - Decompose the problem
>   - Functional (shared) or data (distributed), or both
> - Code development
>   - Choose a model to concentrate on
>   - Data dependencies
>   - Divide code where for task or communication control
> - Compile, Test, Debug, Optimize
>
{: .checklist}

{% include links.md %}
