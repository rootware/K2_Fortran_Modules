!SDE_kick routines, written by Shah Saad Alam, Rice University
!email @ Shah.Saad.Alam@rice.edu
!--------------------
! This routine contains the actual kick function, which takes in an initial
! first invariant value Mi and initial parallel component of momentum,
! converts both to alpha_0, p coordinates, does the kick there,
! and converts the final alpha_0,p back to M, and p_parallel.
!----------------------
! For more detailed background, see the file:
! "Summary of SDE for K2" available online by request.
!----------------------

module sde
  use mtdefs
  use mtmod
  use coef
  use conversion

contains	
  subroutine sde_kick(Mi, pi_par, r, B, t_dim, ds_dim, Mf, pf_par)

    ! Respectively, initial M, initial p_parallel,
    ! local magnetic field strength,
    ! time in days with t=0 at 17th March 2013,
    ! ds is the time step for kick
    real , intent (in) :: Mi, pi_par, B, t_dim, ds_dim

    ! r is 3d position vector in cartesian coordinates
    real, dimension(3) :: r

    ! final M, final p_parallel
    real, intent (out) :: Mf, pf_par

    
    real :: L, pi_perp, pi,pf, phi, ai,af

    ! seed for random number gen
    integer seed

    ! two random numbers
    real :: N1,N2

    ! coefficients sigma_11,sigma_21, sigma_22 and
    ! b1, b2 as defined in file
    real, dimension(3) :: sigma
    real, dimension(2) :: bv

    real ::t, ds
    t=t_dim/47.031403*1/(24*3600);
    ds=ds_dim/47.031403*1/(24*3600);
    
    ! get system time
    call system_clock(seed)

    ! seed randum num ge
    call sgrnd(seed)
    
    L = sqrt( r(1)**2 + r(2)**2 + r(3)**2 )
    pi_perp = sqrt( 2*Mi*B )
    pi = sqrt( pi_perp**2 + pi_par**2 )
    phi = atan2( r(2), r(1) )+PI_8;
    ai = acos(pi_par/pi);

    ! function defined in coef.F90
    ! pass initial alpha_0 in degrees,
    ! initial momentum, L, phi, t,
    ! and get the local sigma and b coefficients
    call getsigmab(ai*180.0/PI_8 , pi, L, phi, t , sigma, bv)

    ! get randum numbers
    N1 = gaussrnd()
    N2 = gaussrnd()
    write(*,*) "Initial a,p"
    write(*,*) ai,pi
    ! Do the kick

    write(*,*) "Our coefficients are"
    write(*,*) sigma, bv
    af = ai + bv(1)*ds + sigma(1)*sqrt(ds)*N1 
    pf = pi + bv(2)*ds + sigma(2)*sqrt(ds)*N1+ sigma(3)*sqrt(ds)*N2
    write(*,*) "Final a,p"
    write(*,*) af,pf

    ! check whether af is negative or greater than 90degrees.
    if (af <0) then
       af= -af;
    end if
    
    if (af> PI_8/2) then
       af= PI_8-af;
    end if
    

    ! Calculate the final M, final p_parallel
    Mf = (pf*sin(af))**2 / ( 2*B)
    pf_par = pf * cos(af)

    
  end subroutine sde_kick

end module sde
