// Load the OpenMP functions library
#include<omp.h>

int main()
{
  // Set and initialise variables
  int tnum=0, incr=0;
    
  // Start parallel block
  // #pragma omp parallel private(tnum)
  //  {
    // Start a critical block that we want only one thread to access
    // at a time. Note that the 'incr' variable is NOT private!
  // #pragma omp critical
  //    {
      incr = incr + 1;
  //    }
  
    // Wait here with barrier
    // #pragma omp barrier
    // The master thread prints out the results of the calculation and
    // then does some other processing that the other threads have to
    // wait for.
    // #pragma omp master
  //    {
      tnum = omp_get_thread_num();
      printf("Master thread is number %d\n", tnum);
      printf("Summation = %d\n", incr);
      sleep (10);
   //    }

    // Ensure ALL threads have finished their processing before continuing.
  //#pragma omp barrier
  //    {
      printf("finished!\n");
  //    }
  //  }
    
  return 0;
}
