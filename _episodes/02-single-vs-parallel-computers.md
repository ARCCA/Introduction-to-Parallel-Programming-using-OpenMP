---
title: "Single vs Parallel computers"
teaching: 10
exercises: 0
questions:
- "What we understand as a single computer?"
- "What we understand as a parallel computer?"
- "What are some of the key elements that determine a computer's performance?"
objectives:
- "Understand the difference between single and paralllel computers"
- "Identify some key elements that determine a computer's performance"
keypoints:
- "Clock speed and number of cores are two key elements that affect a computer's performance"
- "A single computer is typically understood as a single core CPU"
- "A parallel computer is typically understood as a multi core CPU"
- "Multiple cores in a parallel computer are able to share a CPU's memory"
---

## Single computers

<figure>
  <img src="{{ page.root }}/fig/single_computer.svg" alt="Single computer" width="40%" height="40%" />
</figure>

A Central Processing Unit, or **CPU**, is a piece of hardware that enables your computer to interact with all of the applications and programs installed in a computer. It interprets the program’s instructions and creates the output that you interface with when you’re using a computer. A computer **CPU** has direct access to the computer's memory to read and write data necessary during the software execution.

As CPUs have become more powerful, they have allowed to develop applications with more features and capable of handling more demanding tasks, while users have become accustomed to expecting a nearly instantaneous response from heavy multitasking environments. 

## Make it go faster
When we talk about a computer's speed, we typically are referring to its performance when interacting with applications. There are three main factors that can impact a computer's performance:

- *Increase **clock speed***: Clock speed refer to the number of instructions your computer can process each second and is typically measured in GHz, with current gaming desktop computers in the order of 3.5 to 4 GHz.

-  *Increase the **number of CPUs***: Ideally, we would like to have the best of both worlds, as many processors as possible with clock speed as high as possible, however, this quickly becomes expensive and limiting due to higher energy demand and cooling requirements.

-Available ***vector instructions***: Modern **CPUs** are equipped with the capacity to apply the same instruction to multiple data points simultaneously, this is known as **SIMD** instructions.

> ## Did you know?
>
> Hawk has two types of **CPUs** available:
> - Xeon Gold 6148 (Skylake) at 2.4GHz clock speed, 20 **cores** per node and support for AVX512 instructions.
> - AMD Epyc Rome 7502 at 2.5 GHz clock speed, 32 **cores** per node and support for AVX256 instructions. 
> 
> Find out more here: [https://portal.supercomputing.wales/index.php/about-hawk/]
>
{: .callout}

## Parallel computers
<figure>
  <img src="{{ page.root }}/fig/parallel_computer.svg" alt="Single computer" width="40%" height="40%" />
</figure>

Since Intel Pentium 4 back in 2004, which was a single core **CPU**, computers have gradually increased the number of cores available per **CPU**. This trend is pushed forward by two main factors: 1) a physical limit to the number of transistors that can be fit in a single core, 2) the speed at which these transistors can change state (on/off) and the related energy consumption.

Reducing a CPU clock speed reduces the power consumption, but also its processing capacity. However, since the relation of clock speed to power consumption is not linear, effective gains can be achieved by adding multiple low clock speed CPUs.

Although CPU developers continue working towards increasing CPU clock speeds by engineering, for example, new transistor geometries, the way forward to achieve optimal performance is to learn to divide computations over multiple cores, and for this purpose we could keep in mind a couple of old sayings:

<blockquote>
“Many hands make light work”
</blockquote>

<blockquote>
“Too many cooks spoil the broth”
</blockquote>

> ## Thinking about programming
>
> - Decompose the problem
>   - Divide the algorithm (car production line) - Breaking a task into steps performed by different processor units. 
>   - Divide the data (call centre) - If well defined operations need to be applied on independent pieces of data.
> - Distribute the parts 
>   - work in parallel
> - Considerations
>   - Synchronisation
>   - Communicate between processor
> - Hardware issues
>   - What is the architecture being used?
>
{: .callout}

{% include links.md %}
