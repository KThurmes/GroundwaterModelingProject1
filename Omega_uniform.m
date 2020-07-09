function [ omega ] = Omega_uniform(z, Qo, alpha)
%OMEGA_UNIFORM returns the complex potential of a uniform flow
%   
omega = -Qo*exp(1i*-alpha)*z;
end

