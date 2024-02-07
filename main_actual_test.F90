program Main

  use sde
  use coef
  use conversion

  implicit none


  real(8) :: Mi, pi_par , B, t, Mf, pf_par, ds
  real(8) , dimension(3) :: r
  real(8), parameter :: Mi0=7.25e-3;
  real(8), parameter :: pi_par_0=-1.42;
  integer :: steps, seed
  real(8) :: dx2;
  integer :: TIME;
  integer, parameter::totparticle=500;

  Mi = Mi0;
  pi_par = pi_par_0;

  t =0;

  r(1)=1.4;;
  r(2)=-2.3;
  r(3)= 0;

  ds=5.7;!convert from
  B=395;


  call readCoordinates()

  call readMasterFile()
  open(UNIT=14, FILE="test_1.txt", FORM="FORMATTED",STATUS="NEW", ACTION="WRITE")
  open(unit=16, file='dx2.txt', FORM="FORMATTED",STATUS="NEW", ACTION="WRITE")

  do TIME=10000,100000, 10000
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
           call sde_kick(Mi, pi_par, r, B, t , ds , Mf, pf_par);

           t=steps*ds;
           Mi=Mf;
           pi_par=pf_par;
           if (particle==1 .and. time==100) then 
              write(unit=14, fmt=*) t,Mi, pi_par
           end if

        end do

        dx2=dx2+(Mi-Mi0)**2;

     end do

     write(unit=16, fmt=*) TIME*ds, dx2/totparticle !average for particles
  end do

  write(*,*) "END OF PROGRAM"
  close(14)
  close(16)


end program Main
