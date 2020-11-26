program my_first_thread

    implicit none

    integer, parameter :: n = 10
    integer :: i

    !$OMP PARALLEL DO PRIVATE(i)
    DO i=1,n
        PRINT *, "I am counter i = ", i
    ENDDO
    !$OMP END PARALLEL DO

end program my_first_thread
