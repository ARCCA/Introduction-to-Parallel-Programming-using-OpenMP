program set_threads

    ! Load the OpenMP functions library
    use omp_lib

    ! Set variables
    implicit none
    integer :: tnum

    ! Create a parallel block of four threads (including master thread)
    !$OMP PARALLEL PRIVATE(tnum) NUM_THREADS(4)
        tnum = OMP_GET_THREAD_NUM()
        print *, "I am thread number", tnum
    !$OMP END PARALLEL

    ! Create a parallel block, without specifying the number of threads
    !$OMP PARALLEL PRIVATE(tnum)
        tnum = OMP_GET_THREAD_NUM()
        print *, "Second block, I am thread number", tnum
    !$OMP END PARALLEL

end program set_threads
