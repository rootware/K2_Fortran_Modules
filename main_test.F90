program Main
  use sde
  use coef
  use conversion
  use mtdefs
  use mtmod
  implicit none
  
  real(8)::start_p=0;
  real(8)::end_p=0;
  integer:: steps, seed
  integer :: particle
  real(8) :: ds=1e-2;
  real(8)::t=0;
  real(8) :: B=100;
  real(8), dimension(3) :: r;
  real(8):: Mi,Mf
  real(8):: pi,pf
  real(8):: dx2;
  integer:: TIME;
  integer:: totparticle=500;


  call readCoordinates()

  call readMasterFile()

  open(UNIT=14, FILE="test_1.txt", FORM="FORMATTED",STATUS="NEW", ACTION="WRITE")
  open(unit=16, file='dx2.txt', FORM="FORMATTED",STATUS="NEW", ACTION="WRITE")

  do TIME=50,200
     dx2=0;
     particle=1;
     do particle=1,totparticle
        ai=1.5;
        r(1)=1;
        r(2)=2;
        r(3)=4;
        pi=1;

        t=0;
        call system_clock(seed)

        call sgrnd(seed)


        if (particle==1 .and. time==100) then
           write(unit=14,fmt=*) t, pi
        end if

        do steps=1,TIME

           call sde_kick(ai, pi, r, B, t , ds , af, pf);
           t=steps*ds;
           ai=af;
           pi=pf;
           if (particle==1 .and. time==100) then 
              write(unit=14, fmt=*) t,pi
           end if

        end do

        dx2=dx2+(pi-10)**2;

     end do

     write(unit=16, fmt=*) TIME*ds, dx2/totparticle !average for particles
  end do

  write(*,*) "END OF PROGRAM"
  close(14)
  close(16)

end program
