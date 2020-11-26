// Load the OpenMP functions library
#include<omp.h>

int main()
{
  // Set variables
  int num_threads=0, tnum=0, i=0, total=0;

  // Create parallel block
  //#pragma omp parallel
  //  {
    
    //Create a section block
  //#pragma omp sections private(tnum, i)  nowait
  //    {

      // Ask an available thread to print out the thread number.
  //#pragma omp section
  //      {
	tnum = omp_get_thread_num();
	printf("I am thread number %d\n", tnum);
	//      }	  

      // Ask another section to add up the thread numbers
	//#pragma omp section
	//      {
	num_threads = omp_get_num_threads();
	tnum = omp_get_thread_num();
	total = 0;
	for (i=1; i<=num_threads; i++)
	  total = total + i;
	printf("thread number %d says total = %d\n", tnum, total);
	//      }

      // Close the section block. Normally this sets a barrier that requires all
      // the threads to have completed processing by this point, but we've
      // bypassed it with the "nowait" argument.
	//    }
    
    // Print out the fact that the section block has finished. How many threads
    // are still functional at this point?
    printf("Finished sections block\n");

    
    // We only want one thread to operate here.
    //#pragma omp single
    //    {
      tnum = omp_get_thread_num();
      printf("Single thread = %d\n", tnum);
      //    }

    // End parallel block
      //  }
  
  return 0;
}
