int main()
  {
    const int N = 10;
    int i;
    
    #pragma omp parallel for
    for(i = 0; i < N; i++)
    {
        printf("I am counter %d\n", i);
    } 
  }
