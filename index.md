---
layout: lesson
root: .  # Is the only page that doesn't follow the pattern /:path/index.html
permalink: index.html  # Is the only page that doesn't follow the pattern /:path/index.html
---
This session introduces programmers to the basics of parallel programming. OpenMP is a standard method of sharing work amongst threads within the same computer; this has become common recently due to its ease of use and support amongst the most common compilers. OpenMP uses shared memory within the computer to communicate between threads and there are many methods available to distribute the work. OpenMP is written using compiler directives/pragmas to tell the compiler how to distribute pieces of code across the multiple threads.

<!-- this is an html comment -->

{% comment %} This is a comment in Liquid {% endcomment %}

> ## Prerequisites
>
> - Experience of a programming language is required
> - Knowledge of Fortran or C
> - Working knowledge of Linux is essential.
{: .prereq}

{% include links.md %}
