---
title: "GPU support"
teaching: 10
exercises: 5
questions:
- "Some pointers on OpenMP support on GPUs"
objectives:
- "Awareness that OpenMP can be used to program GPUs from different vendors."
keypoints:
- "OpenMP support for GPUs has matured and is now a viable API to develop code
   for GPUs."
---

## Using OpenMP on GPUs

GPUs excel at massively parallel workloads, provided data movement between the
host (CPU) and the device (GPU) is minimized, as transfers across interconnects
like PCIe or NVLink can easily become a performance bottleneck.

Historically, programming GPUs required vendor-specific frameworks—such as
NVIDIA’s CUDA or AMD’s HIP—which locked code into a single hardware ecosystem
and reduced portability. Since OpenMP 4.0 (and significantly expanded in OpenMP
4.5 and 5.x), OpenMP has provided target offloading directives. These allow
developers to offload compute-intensive regions and manage device memory using
standard, portable pragmas across NVIDIA, AMD, and Intel GPUs.

GPU offloading is now mature and production-ready across major compiler
toolchains, including LLVM/Clang, GCC, NVIDIA HPC SDK (nvc/nvc++/nvfortran),
AMD ROCm (amdclang), and Intel oneAPI (icx/ifx). Note that open-source compilers
like GCC and Clang must be built with target offloading backends enabled (e.g.,
nvptx for NVIDIA or amdgcn for AMD) and invoked with the appropriate target flags
(such as -fopenmp -foffload=nvptx-none for GCC, or -fopenmp --offload-arch=native
for Clang).

## Example: Portable CPU/GPU Stencil Loop
To avoid duplicating loop bodies for CPU and GPU targets, you can use conditional
compilation around the OpenMP directives (or use the OpenMP 5.0 `loop` construct).
Notice the explicit `map` clauses, which control data transfers between host and
device memory:

~~~
#ifdef GPU
  #pragma omp target teams distribute parallel for \
      collapse(2) reduction(max:error) \
      map(to: A[0:n][0:m]) map(from: Anew[0:n][0:m])
#else
  #pragma omp parallel for reduction(max:error)
#endif
for (int j = 1; j < n - 1; j++) {
  for (int i = 1; i < m - 1; i++) {
    Anew[j][i] = 0.25 * (A[j][i + 1] + A[j][i - 1] + A[j - 1][i] + A[j + 1][i]);
    error = fmax(error, fabs(Anew[j][i] - A[j][i]));
  }
}
~~~
{: .language-c}

If interested, come and talk to us and we can see how we can help.

## Further material
- https://www.openmp.org

{% include links.md %}
