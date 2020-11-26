program reduc

    ! Load the OpenMP functions library
    use omp_lib

    ! Set variables
    implicit none
    integer :: broad, tnum, calc

    ! Start parallel block
    !$OMP PARALLEL PRIVATE(broad, tnum, calc)

    ! We want a single thread to broadcast a value to the entire block of
    ! threads.
    !$OMP SINGLE
        broad = OMP_GET_THREAD_NUM()
    !$OMP END SINGLE COPYPRIVATE(broad)

    ! Print out the broadcast value
    print *, "broad =", broad
   
    !$OMP END PARALLEL

    calc = 0
    ! Each thread in this block will perform a calculation based on its thread
    ! number. These results are then reduced by performing an action on them, in
    ! this case a summation.
    !$OMP PARALLEL PRIVATE(tnum) REDUCTION(+:calc)

        tnum = OMP_GET_THREAD_NUM()
        calc = 2**tnum
        print *, "Thread number =", tnum, " calc = ", calc
    
    !$OMP END PARALLEL
    print *, "Reduction =", calc

end program reduc
