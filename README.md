# K2_Fortran_Modules
Author: Shah Saad Alam

During my Masters in Computational Space and Plasma Physics, I was a Graduate Researcher with Prof. Anthony Chan. 
These Fortran modules were written as part of my contribution to the K2 Space Weather Modelling project during my Masters in S.Created this repo recently mostly for personal reference.

## Code Notes:
This code was designed to take in diffusion coefficients data in pitch-angle and momentum $\alpha_0, p$ coordinates, and simulate the kinetics of radiation belt electrons in adiabatic invariant space and convert back. Eventual goal for these modules was for integration into other, larger, simulation codebase.

- _script_ contains the compilation command
- Relevant equations for this project are in the .pdf file.
- The code takes in a _masterfile.txt_, omitted here because of sheer size, which contains the diffusion coefficient data. I generated the file using C++ code (included in another repo `K2_Project`) that calculates Upper and Lower Chorus Wave Diffusion coefficients from pre-cursor files  and compiles them into _masterfile.txt_. Idea was this file and Fortran code could then be used alongside larger simulation codebases.
- _PitchAngle\_46.txt_ and _Energy\_71.txt_ contain the coordinate files.
- `mtfort90,F90` is a Mersenne Twister codebase I found, credits are in file comments.
