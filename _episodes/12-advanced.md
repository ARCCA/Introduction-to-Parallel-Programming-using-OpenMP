---
title: "Advanced features"
teaching: 10
exercises: 5
questions:
- "Some pointers on further OpenMP features"
objectives:
- "Understand further material and topics that can used."
keypoints:
- "OpenMP is still an evolving interface to parallel code."
---

## Using OpenMP on GPUs

GPUs are very efficient at parallel workloads where data can be offloaded to the device and processed since
communication between GPU and main memory is limited by the interface (e.g. PCI).

NVIDIA GPUs are available and usually programmed using NVIDIA's own CUDA technology.  This leads to code that is limited
to only working on NVIDIA's ecosystem. This limits choice for the programmer and portability for others to use your
code.  Recent versions of OpenMP since 4.0 has supproted `offload` functionality.

Info from Nvidia suggests this is possible but still work in progress.  Compilers have to be built to support CUDA (LLVM/Clang is one such compiler).

Example code is:

~~~
#pragma omp \
#ifdef GPU
target teams distribute \
#endif
parallel for reduction(max:error) \
#ifdef GPU
collapse(2) schedule(static,1)
#endif
for( int j = 1; j < n-1; j++)
{
  for( int i= 1; i < m-1; i++ )
  {
    Anew[j][i] = 0.25 * ( A[j][i+1] + A[j][i-1]+ A[j-1][i] + A[j+1][i]);
    error = fmax( error, fabs(Anew[j][i] -A[j][i]));
  }
}
~~~
{: .language-c}

If interested, come and talk to us and we can see how we can help.

## Further material
- https://www.openmp.org

{% include links.md %}
