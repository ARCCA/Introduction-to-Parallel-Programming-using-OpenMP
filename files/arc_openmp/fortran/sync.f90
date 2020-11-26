program sync

    ! Load the OpenMP functions library
    use omp_lib
    use ifport

    ! Set variables
    implicit none
    integer :: tnum, incr

    ! Initialise the incr variable
    incr = 0

    ! Start parallel block
    !$OMP PARALLEL PRIVATE(tnum)

    ! Start a critical block that we want only one thread to access
    ! at a time. Note that the 'incr' variable is NOT private!
    !$OMP CRITICAL
        incr = incr + 1
    !$OMP END CRITICAL
    
    ! Wait here for all threads
    !$OMP BARRIER

    ! The master thread prints out the results of the calculation and
    ! then does some other processing that the other threads have to
    ! wait for.
    !$OMP MASTER
        tnum = OMP_GET_THREAD_NUM()
        print *, "Master thread is number", tnum
        print *, "Summation =", incr
        call sleep (10)
    !$OMP END MASTER 
    
    ! Ensure ALL threads have finished their processing before continuing.
    !$OMP BARRIER
    print *, "finished!"

    !$OMP END PARALLEL

end program sync
