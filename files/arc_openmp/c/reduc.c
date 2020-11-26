// Load the OpenMP functions library
#include<omp.h>
#include<math.h> //for pow function

int main()
{
  // Set and initialise variables
  int broad=0, tnum=0, calc=0;
  
  // Start parallel block
  // #pragma omp parallel private(broad,tnum,calc)
  //   {
    // We want a single thread to broadcast a value to the entire block of
    // threads.
  // #pragma omp single copyprivate(broad)
  //    {
      broad = omp_get_thread_num();
  //    }

    // Print out the broadcast value
    printf("broad = %d\n", broad);
    
  //  }

  calc = 0;
  // Each thread in this block will perform a calculation based on its thread
  // number. These results are then reduced by performing an action on them, in
  // this case a summation.
  // #pragma omp parallel private(tnum) reduction(+:calc)
  //  {
    tnum = omp_get_thread_num();
    calc = pow(2,tnum);
    printf("Thread number = %d calc = %d\n",tnum, calc);
  //  }

  printf("Reduction = %d\n", calc);
    
  return 0;
}
