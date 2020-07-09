function [ omega ] = OmegaAll( Qw, z, spaces, strengths, Qo, alpha, const, zw,rw)
%OMEGAALL Designed specifically for Project 1. Gives the complex potential
%for all elements in the field
omega = Omega_uniform(z, Qo, alpha);
omega = omega + const; 
n_ls = size(spaces, 1);
num_wells = length(zw);
for i = 1:n_ls
    z1 = spaces(i,1);
    z2 = spaces(i,2);
    Z = CapZ(z,z1,z2);
    L = abs(z1-z2);
    sigma = strengths(i,1);
    omega = omega + sigma * Omega_LineSink(Z,L);
end
    for j = 1:num_wells
        omegawell = Qw(j)*Omega_well(z,zw(j),rw);
        omega = omega + omegawell;
    end
end

