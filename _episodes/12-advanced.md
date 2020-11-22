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

## Further material
- https://www.openmp.org

{% include links.md %}
