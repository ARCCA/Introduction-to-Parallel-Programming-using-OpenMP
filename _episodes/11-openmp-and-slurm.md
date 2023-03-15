---
title: "OpenMP and Slurm"
teaching: 15
exercises: 5
questions:
- "Some pointers on how to run OpenMP on Slurm"
objectives:
- "Some considerations when submitting OpenMP jobs to Slurm"
keypoints:
- "Use Slurm *--cpus-per-task* option to request the number of threads"
- "Set OMP_NUM_THREADS equal to the number of cpus per task requested"
- "Be careful not to exceed the number of cores available per node"
---

## Using OpenMP and Slurm together
Slurm can handle setting up OpenMP environment for you, but you still need to do some work.
~~~
....
#SBATCH –-cpus-per-task=2
...

# Slurm variable SLURM_CPUS_PER_TASK is set to the value
# of --cpus-per-task, but only if explicitly set

# Set OMP_NUM_THREADS to the same value as --cpus-per-task
# with a fallback option in case it isn't set.
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1}

... run your OpenMP program ...

~~~
{: .language-bash}

Make sure you specify tasks as 1 if only using OpenMP.
If using MPI and OpenMP you have to be careful to specify --ntasks-per-node and --cpus-per-task to not exceed the number of cores on the node.

~~~
....
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH –-cpus-per-task=2
...

# Slurm variable SLURM_CPUS_PER_TASK is set to the value
# of --cpus-per-task, but only if explicitly set

# Set OMP_NUM_THREADS to the same value as --cpus-per-task
# with a fallback option in case it isn't set.
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1}

... run your MPI/OpenMP program ...

~~~
{: .language-bash}

## High-level control

Slurm has options to control how CPUs are allocated.  See the `man` pages or try the following for `sbatch`.

`--sockets-per-node=S` : Number of sockets in a node to dedicate to a job (minimum)

`--cores-per-socket=C` : Number of cores in a socket to dedicate to a job (minimum)

`--threads-per-core=T` : Number of threads in a core to dedicate to a job (minimum)

`-B S[:C[:T]]` : Combined shortcut option for `--sockets-per-node`, `--cores-per_cpu`, `--threads-per_core` 

## Further training material

- [https://www.openmp.org/resources/tutorials-articles/](https://www.openmp.org/resources/tutorials-articles/)
- [https://hpc-tutorials.llnl.gov/](https://hpc-tutorials.llnl.gov/)

{% include links.md %}
