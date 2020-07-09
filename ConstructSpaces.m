function [spaces] = ConstructSpaces( linescoords,  b)
%CONSTRUCTDIFFERENT takes a series of lines and creates the matrix for
%finding the strengths of the line-sinks and the constant potential. There
%is also opportunity for using this function to create a matrix that will
%find the uniform flow rate or the discharge of a well, if a unit discharge
%or flow is used.
%b will be the number of sub-sinks that each length of river will be
%divided into
%This part constructs a matrix that includes the start and end points of a
%series of line-sinks and the centers of those line-sinks.

r = size(linescoords,1);
n= r/2;
spaces = NaN(n*b,3);

%set up a matrix with all the start and end points in the first and second
%columns and the mid point in the third column.

for i = 1:n
    z1 = linescoords(2*i-1,1)+1i*linescoords(2*i-1,2);
    z2 = linescoords(2*i,1)+1i*linescoords(2*i,2);
    row = linspace(z1, z2, b+1);
    for j = 1:b
        z_one = row(1,j);
        z_two = row(1,j+1);
        middle = (z_one+z_two)/2;
        spaces((((i-1)*b)+j),[1,2,3])= [z_one,z_two,middle];
        if (((i-1)*b)+j)>44
            spaces((((i-1)*b)+j),[1,2,3])= [z_two,z_one,middle];
        end
    end  
end

end


