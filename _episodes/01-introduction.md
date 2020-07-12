---
title: "Introduction"
teaching: 0
exercises: 0
questions:
- "What are some common terms in parallel computing?"
- "Why use parallel computing?"
objectives:
- "Familiarize with common hardware and software terms in parallel computing"
- "Obtain a general overview of the evolution of multi core computers in time"
keypoints:
- "A **core** is a physical independent execution unit capable of running one program thread."
- "A **node** is another term to refer to a computer in a network."
- "In recent years computers with several cores per CPU have become the norm and are likely to continue being into future."
- "Learning parallelization techniques let you exploit multi core systems more effectively"
---

> ## Terminology
>
> Hardware 
> - **CPU** = Central Processing Unit
> - **Core** = Processor = PE (Processing Element)
> - **Socket** = Physical slot to fit one CPU.
> - **Node** = In a computer network typically refers to a host computer.
> 
> Software
> - **Process** (Linux) or **Task** (IBM)
> - **MPI** = Message Passing Interface
> - **Thread** = some code / unit of work that can be scheduled
> - **OpenMP** = (Open Multi-Processing) standard for shared memory programming
> - User Threads = tasks * (threads per task)
>
{: .checklist}

A **CPU** is a computer's Central Processing Unit that is in charge of executing the instructions of a program. Modern **CPUs** contain multiple **cores** that are physical independent execution units capable of running one program thread. **CPUs** are attached to a computer's motherboard via a **socket** and high-end motherboards can fit multiple **CPUs** using multiple sockets. A group of computers (hosts) linked together in a network conform a cluster in which each individual computer is referred as a **node**. Clusters are typically housed in server rooms, as is the case for Hawk supercomputer located at the Redwood Building in Cardiff University.

<figure>
  <img src="{{ page.root }}/fig/Nodes.svg" alt="Common HPC hardware elements" width="60%" height="60%" />
</figure>


## Why go parallel?
Over time the number of cores per socket have increased considerably, making parallel work on a single computer possible and parallel work on multiple computers even more powerful. The following figure shows the change in market share of number of Cores per Socket as a function of time. In the early 2000's it was more common for systems to have a single core per socket and just a few offered a dual core option. Fast forward to late 2019 and the landscape has changed a lot with several options now available. Systems with 20 cores per socket represented 35% of the market (as with Hawk's Skylake CPUs) while systems with 32 cores per socket represented only 1.2% (as with Hawk's AMD Epyc Rome CPUs). Will this trend continue? It is likely, and therefore, it is worth investing in learning how parallel software works and what parallelization techniques are available.

<figure>
  <img src="{{ page.root }}/fig/openmp_Cores-per-Socket.png" alt="Cores per Socket - systems Share" width="60%" height="60%" />
  <figcaption>Cores per Socket - Systems Share. Source: Source: Top 500 - http://www.top500.org </figcaption>
</figure>


{% include links.md %}

