// Load the OpenMP functions library
#include<omp.h>

int main()
  {
    int nthreads, tid;
    // Fork a team of threads, with private versions of the declared variables.
    // #pragma omp parallel private(nthreads, tid)
    // {
    // Get the thread number and print it 
    tid = omp_get_thread_num();
    printf("Hello World from thread number %d\n", tid);

    // Only the master thread does the following
    // #pragma omp barrier
    // #pragma omp master
    // {    
    if (tid == 0)
      {
	nthreads = omp_get_num_threads();
	printf("Number of threads = %d\n", nthreads);
      }
    // }
    
    // End of pragma, disband all but the master thread
    //}
    return 0;
  }
