program Main

  use sde
  use coef
  use conversion

  implicit none


  real :: Mi, pi_par , B, t, Mf, pf_par, ds
  real , dimension(3) :: r


  Mi = 7.25e-3;! initial M value
  pi_par = -1.42;! initial p parallel value
 
  t =16.99; ! initial time in DAYS since 17th march
  ! e.g. t=0 is start of 17th March, t=1 is start of 18th March
 
  r(1)=1.4;; ! x component of position
  r(2)=-2.3; ! y component of position
  r(3)= 0; ! z component of position

  ds=5.7;! time step, in K2 time units
  B=395; ! Magnetic field


  call readCoordinates()

  call readMasterFile()

  write(*,*) "Initial M, p_par"
  write(*,*) Mi, pi_par
  call sde_kick(Mi, pi_par, r, B, t , ds , Mf, pf_par);
  write(*,*) "Final M, p_Par"
  write(*,*) Mf, pi_par

	
end program Main
