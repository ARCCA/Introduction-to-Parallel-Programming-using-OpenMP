#include<omp.h>
#include<stdlib.h>

int main()
{
    srand (0);
    int i;
    int N=20;
    int my_rand[N];
    int best_cost=RAND_MAX;

    for (i=0; i<N; i++)
    {
      my_rand[i] = rand();
    }

    #pragma omp parallel shared(best_cost)
    {
        #pragma omp for nowait
        for (i=0; i<N; i++)
        {
            int tid = omp_get_thread_num();
            int my_cost;
            // Be careful using rand in OpenMP parallel regions.
            my_cost = my_rand[i] % 100;
            printf("tid %i -  %i\n",tid,my_cost);
            //#pragma omp critical
            if(best_cost > my_cost)
            {
                printf("tid %i says that %i is lower than %i \n",tid,my_cost,best_cost);
                best_cost = my_cost;
            }
        }
     }
     printf("Best cost %d\n",best_cost);
}

