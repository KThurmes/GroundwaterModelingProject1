function [ omega ] = Omega_LineSink( Z,L )
%LINESINK Gives the complex potential for a line sink of unit infiltration
%rate
omega = L/(4*pi)*((Z+1)*log(Z+1)-(Z-1)*log(Z-1)+2*log(L/2)-2);
end

