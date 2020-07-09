function [A,bm] = ConstructingMatrices2( spaces, func, Phim, constants)
%CONSTRUCTINGMATRICES2 Takes a list of line-sinks (spaces), a known function, the potential at the line-sinks, and a list of constants and returns the
%matrices for solving for the strengths of the line-sinks and the constant
%in the equation.
n = size(spaces,1);
A = zeros(n+1,n+1);
bm = zeros(n+1,1);

%Constructing A
for m = 1:n+1 
    if m == n+1
        zcm = constants(1);
        bm(m,1)=constants(2)-real(func(zcm));
    else
        zcm = spaces(m,3);
        bm(m,1)=Phim-real(func(zcm));
    end
    %let's construct bm while we're here.
    
    for j = 1:n
        z1j = spaces(j,1);
        z2j = spaces(j,2);
        Z = CapZ(zcm,z1j,z2j);
        L = abs(z2j-z1j);
        A(m,j)=real(Omega_LineSink(Z,L));
    end
    A(m,(n+1))=1;
end
end



