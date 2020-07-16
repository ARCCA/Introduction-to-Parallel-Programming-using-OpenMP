---
title: "Openmp and slurm"
teaching: 0
exercises: 0
questions:
- "Some pointers on how to run OpenMP on SLURM"
objectives:
- "Some considerations when submitting OpenMP jobs to SLURM"
keypoints:
- "Use SLURM *--cpus-per-task* option to request the number of threads"
- "Set OMP_NUM_THREADS equal to the number of cpus per task requested"
- "Be careful not to exceed the number of cores available per node"
---

## Using OpenMP and SLURM together
SLURM can handle setting up OpenMP environment for you, but you still need to do some work.
~~~
....
#SBATCH –-cpus-per-task=2
...

# SLURM variable SLURM_CPUS_PER_TASK is set to the value
# of --cpus-per-task, but only if explicitly set

# Set OMP_NUM_THREADS to the same value as --cpus-per-task
# with a fallback option in case it isn't set.
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads

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

# SLURM variable SLURM_CPUS_PER_TASK is set to the value
# of --cpus-per-task, but only if explicitly set

# Set OMP_NUM_THREADS to the same value as --cpus-per-task
# with a fallback option in case it isn't set.
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads

... run your MPI/OpenMP program ...

~~~
{: .language-bash}


## Further training material
- https://www.openmp.org/resources/tutorials-articles/
- https://hpc.llnl.gov/training/tutorials

{% include links.md %}
