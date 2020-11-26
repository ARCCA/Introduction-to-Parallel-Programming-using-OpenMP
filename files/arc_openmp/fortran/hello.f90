program hello_world

    ! Load the OpenMP functions library
    use omp_lib

    implicit none

    integer :: nthreads, tid

    !  Fork a team of threads, with private versions of the declared variables.
    !$OMP PARALLEL PRIVATE(nthreads, tid)

    ! Get the thread number and print it 
    tid = OMP_GET_THREAD_NUM()
    print *, "Hello World from thread number ", tid

    ! Only the master thread does the following
    if (tid == 0) then
        nthreads = OMP_GET_NUM_THREADS()
        print *, "Number of threads = ", nthreads
    end if

    ! Disband all but the master thread
    !$OMP END PARALLEL

end program hello_world
