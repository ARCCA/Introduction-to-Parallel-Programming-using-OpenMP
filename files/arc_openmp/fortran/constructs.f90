program constructs

    ! Load the OpenMP functions library
    use omp_lib

    ! Set variables
    implicit none
    integer :: num_threads, tnum, i, total

    ! Create parallel block
    !$OMP PARALLEL

    ! Create a section block
    !$OMP SECTIONS PRIVATE(tnum, i)
    
    ! Ask an available thread to print out the thread number.
    !$OMP SECTION
        tnum = OMP_GET_THREAD_NUM()
        print *, "I am thread number", tnum

    ! Ask another section to add up the thread numbers 
    !$OMP SECTION
        num_threads = OMP_GET_NUM_THREADS()
        tnum = OMP_GET_THREAD_NUM()
        total = 0
        DO i = 1, num_threads
            total = total + i
        ENDDO
        print *, "thread number ", tnum, "says total =", total

    ! Close the section block. Normally this sets a barrier that requires all
    ! the threads to have completed processing by this point, but we've
    ! bypassed it with the NOWAIT argument.
    !$OMP END SECTIONS NOWAIT

    ! Print out the fact that the section block has finished. How many threads
    ! are still functional at this point?
    print *, "Finished sections block"

    ! We only want one thread to operate here.
    !$OMP SINGLE
        tnum = OMP_GET_THREAD_NUM()
        print *, "Single thread =", tnum
    !$OMP END SINGLE

    ! End parallel block
    !$OMP END PARALLEL

end program constructs
