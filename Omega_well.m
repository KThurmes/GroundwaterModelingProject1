function [ omega ] = Omega_well( z,zw,rw )
%Omega_well returns the complex potential of a well of unit discharge
%  
if((z - zw) * conj(z - zw) < rw^2)
    omega = 0;
else
    omega = 1/(2*pi)*log((z-zw)/rw);
end
end

