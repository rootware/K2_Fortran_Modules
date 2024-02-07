module conversion

  real, parameter :: PI_8= 4.0*atan(1.0);

contains
  ! E in MeV
  real function E_from_p(pi)
    real , intent(in) :: pi;

    E_from_p= (sqrt(pi**2 + 1)-1)*.511;
    return
  end function E_from_p



    
  

end module conversion
