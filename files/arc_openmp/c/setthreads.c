// Load the OpenMP functions library
#include<omp.h>

int main()
{
  // Set variables
  int tnum=0;
    
  // Create a parallel block of four threads (including master thread)
/* #pragma omp parallel private(tnum) num_threads(4) */
/*   {     */
    tnum = omp_get_thread_num();
    printf("I am thread number: %d\n", tnum);
  /* } */

  // Create a parallel block, without specifying the number of threads
/* #pragma omp parallel private(tnum) */
/*   {     */
    tnum = omp_get_thread_num();
    printf("Second block, I am thread number %d\n", tnum);
  /* } */
    
  return 0;
}
