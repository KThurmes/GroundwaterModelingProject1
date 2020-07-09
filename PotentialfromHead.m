function [ pot ] = PotentialfromHead( k, H, b, phi)
%POTENTIALTOHEAD 
%   
if(phi>(H+b))
    pot = k*H*(phi-b)-.5*k*H^2;
else
    pot = 0.5*k*(phi-b)^2;
end
end

