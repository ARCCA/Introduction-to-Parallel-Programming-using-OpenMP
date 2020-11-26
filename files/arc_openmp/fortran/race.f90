program hello_world

    ! Load the OpenMP functions library
    use omp_lib

    implicit none

    integer :: i, best_cost, tid, my_cost
    integer, parameter :: N = 20

    ! Seed random number
    call random_seed(put=(/0/))
    best_cost=huge(best_cost)

    !  Fork a team of threads, with private versions of the declared variables.
    !$OMP PARALLEL SHARED(best_cost) PRIVATE(tid, my_cost)

    !$OMP DO
    do i = 1, N
      ! Note check thread-safety of random generator.
      call random_number(my_cost)
      my_cost = floor(my_cost*100)
      print *, "tid ", tid, " - ", tid, my_cost
      !$OMP OMP CRITICAL
      if (best_cost > my_cost) then
        print *, "tid ", tid, " says that ", my_cost, " is lower than ", best_cost
        best_cost = my_cost
      end if
    end do
    !$OMP END DO NOWAIT

    ! Disband all but the master thread
    !$OMP END PARALLEL

    print *, "Best cost ", best_cost
    
end program hello_world
