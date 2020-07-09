function [ Z ] = CapZ( z, z1,z2 )
%Returns the value of capital Z- a dimesionless variable with value -1 at
%z1 and 1 at z2
Z = (z-.5*(z1+z2))/(.5*(z2-z1));
end