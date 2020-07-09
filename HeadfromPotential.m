function [ phi] = HeadfromPotential( k, H , b , Phi )
%HeadfromPotential Takes a head (phi), a conductivity (k), a height of an
%aquifer (H), and a constant which represents the distance from the base of
%the aquifer from which we are measuring head (b). This returns the
%potential.
%   
if(Phi > 0.5*k*H^2)
    phi = Phi/(k*H)+.5*H+b;
elseif (Phi<0)
    phi = b;
else
    phi = sqrt(2*Phi/k)+b;
end

