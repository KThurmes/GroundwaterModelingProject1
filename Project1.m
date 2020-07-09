%make sure the data is in there
clear
load('datafile.mat');

%create a plot of the area of interest
MakingtheFieldDynamic(-2000,2000,-1500,1500,Project_1_datafile);

%These are for-sure values
k = 10; %m/day
H = 1000; %arbitrary- aquifer must be unconfined
phi1 = 22; %m
phi2 = 20.25; %m
phir = 20; %m
b = 0; %m
z1 = Project_1_datafile(1,1)+1i*Project_1_datafile(1,2);
z2 = Project_1_datafile(2,1)+1i*Project_1_datafile(2,2);
Phi1 = PotentialfromHead(k,H,b,phi1); %The potential at z1
Phi2 = PotentialfromHead(k,H,b,phi2); %the potential at z2
Phir = PotentialfromHead(k,H,b,phir); %The potential at the river
zw = 0;
rw = .3;
Qw = 0; %For the first part


%Estimation values were found using a least-squares regression performed with Microsoft
%Excel. When the points on the river were plotted, Excel found a line with
%the equation y = -0.806x+126.2801 to fit the data the best with a R^2
%value of .97701.


alpha = atan(-0.806)+pi/2;%The orientation of the line of best fit, as determined by Excel.

dist1 = 1443.2; %m this is approximately the distance (by inspection) between the far observation well and the river.
Q0 = (Phi1-Phir)/dist1;


FuncKnown = @(z)Omega_uniform(z, Q0,alpha);
constants = [z1,Phi1];
elend = size(Project_1_datafile,1);
linescoords = Project_1_datafile(3:(elend-8),1:2);
spaces = ConstructSpaces(linescoords, 3);
[A,bm] = ConstructingMatrices2( spaces, FuncKnown, Phir, constants);
x = A\bm;
lengthx = size(x,1);
sigmas = x(1:lengthx-1,1);
C = x(lengthx,1);

Phi1 = real(OmegaAll(0,z1,spaces,sigmas,Q0,alpha,C,zw,rw));
phi1 = HeadfromPotential(k,H,b,Phi1);
Phi2 = real(OmegaAll(0,z2,spaces,sigmas,Q0,alpha,C,zw,rw));
phi2 = HeadfromPotential(k,H,b,Phi2);
Phir = real(OmegaAll(0,spaces(1,3),spaces, sigmas, Q0, alpha, C, zw, rw));
phir = HeadfromPotential(k,H,b,Phir);
 
 
%With a single well at the location of the observation well 1 with the discharge found by hand
%  zw = z2;
%  Qw = 196.36; 
%  figure;
%  ContourMe_flow_net(-200,200,50,-300,100,50,@(z)OmegaAll(Qw,z,spaces,sigmas,Q0,alpha,C,zw,rw),30);
%  MakingtheFieldDynamic(-200,200,-300,100,Project_1_datafile);


% %With a single well at the location furthest away from the river 
%  zw = complex(-48.65,-219);
%  Qw = 360;%max without getting any river water into the well
%  figure;
%  ContourMe_flow_net(-200,200,100,-300,100,100,@(z)OmegaAll(Qw,z,spaces,sigmas,Q0,alpha,C,zw,rw),100);
%  MakingtheFieldDynamic(-200,200,-300,100,Project_1_datafile);


% %With a single well at the location furthest away from the river 
 zw = complex(-48.65,-219);
 Qw = 288;%max without getting any river water into the well*0.8
 figure;
 ContourMe_flow_net(-200,200,100,-300,100,100,@(z)OmegaAll(Qw,z,spaces,sigmas,Q0,alpha,C,zw,rw),100);
 MakingtheFieldDynamic(-200,200,-300,100,Project_1_datafile);
 
 Omega1 = OmegaAll(Qw,zw,spaces,sigmas,Q0,alpha,C,zw,rw);
 Headw1 = HeadfromPotential(k,H,b,real(Omega1));
 

wellLineStart = complex(Project_1_datafile(59,1),Project_1_datafile(59,2));
wellLineEnd = complex(Project_1_datafile(60,1),Project_1_datafile(60,2));
wellSpacing = linspace(wellLineStart,wellLineEnd,5);
dist = abs(wellSpacing(1)-wellSpacing(2));%Check to be sure that the distance between wells will be <= 10m.

% Qw_indiv = 360/5;
% Qw = [Qw_indiv, Qw_indiv, Qw_indiv, Qw_indiv, Qw_indiv];
% figure;
% ContourMe_flow_net(-200,300,100,-400,100,100,@(z)OmegaAll(Qw,z,spaces,sigmas,Q0,alpha,C,wellSpacing,rw),30);
% MakingtheFieldDynamic(-200,300,-400,100,Project_1_datafile);

%Three wells on back line
wellSpacing2 = wellSpacing(3:5);
% Qw_indiv = 360/3;
% Qw = [Qw_indiv, Qw_indiv, Qw_indiv];
% figure;
% ContourMe_flow_net(-200,300,100,-400,100,100,@(z)OmegaAll(Qw,z,spaces,sigmas,Q0,alpha,C,wellSpacing2,rw),30);
% MakingtheFieldDynamic(-200,300,-400,100,Project_1_datafile);

%Three wells 
% wellLine2Start = complex(Project_1_datafile(62,1),Project_1_datafile(62,2));
% wellLine2End = complex(Project_1_datafile(61,1),Project_1_datafile(61,2));
% PossibleWellSpaces = linspace(wellLine2End, wellLine2Start,4);
% wellSpacing3 = [wellSpacing(4:5),PossibleWellSpaces(2)];
% figure;
% ContourMe_flow_net(-200,300,100,-400,100,100,@(z)OmegaAll(Qw,z,spaces,sigmas,Q0,alpha,C,wellSpacing3,rw),30);
% MakingtheFieldDynamic(-200,300,-400,100,Project_1_datafile);

%This seems to be the ideal configuration
% Qw_total = 370;
% Qw_indiv = 370/4;
% Qw = [.35*Qw_total, .40*Qw_total, .33*Qw_total, 0*Qw_total];
% wellLine2Start = complex(Project_1_datafile(62,1),Project_1_datafile(62,2));
% wellLine2End = complex(Project_1_datafile(61,1),Project_1_datafile(61,2));
% WellLine2Spaces = linspace(wellLine2End, wellLine2Start,4);
% wellSpacing3 = [wellSpacing(4:5),WellLine2Spaces(2:3)];
% figure;
% ContourMe_flow_net(-200,300,100,-400,100,100,@(z)OmegaAll(Qw,z,spaces,sigmas,Q0,alpha,C,wellSpacing3,rw),30);
% MakingtheFieldDynamic(-200,300,-400,100,Project_1_datafile);

% %this is 0.8* the ideal configuration
Qw_total = 370*.8;
Qw_indiv = 370/4;
Qw = [.35*Qw_total, .40*Qw_total, .33*Qw_total, 0*Qw_total];
wellLine2Start = complex(Project_1_datafile(62,1),Project_1_datafile(62,2));
wellLine2End = complex(Project_1_datafile(61,1),Project_1_datafile(61,2));
WellLine2Spaces = linspace(wellLine2End, wellLine2Start,4);
wellSpacing3 = [wellSpacing(4:5),WellLine2Spaces(2:3)];
figure;
ContourMe_flow_net(-200,300,100,-400,100,100,@(z)OmegaAll(Qw,z,spaces,sigmas,Q0,alpha,C,wellSpacing3,rw),30);
MakingtheFieldDynamic(-200,300,-400,100,Project_1_datafile);
% 
% 
% %%%Heads at wells
zw1 = wellSpacing3(1);
zw2 = wellSpacing3(2);
zw3 = wellSpacing3(3);
%zw4 = wellSpacing3(4);
Omega1 = OmegaAll(Qw,zw1,spaces,sigmas,Q0,alpha,C,wellSpacing3,rw);
Omega2 = OmegaAll(Qw,zw2,spaces,sigmas,Q0,alpha,C,wellSpacing3,rw);
Omega3 = OmegaAll(Qw,zw3,spaces,sigmas,Q0,alpha,C,wellSpacing3,rw);
%Omega4 = OmegaAll(Qw,zw4,spaces,sigmas,Q0,alpha,C,wellSpacing3,rw);
Headw1 = HeadfromPotential(k,H,b,real(Omega1));
Headw2 = HeadfromPotential(k,H,b,real(Omega2));
Headw3 = HeadfromPotential(k,H,b,real(Omega3));
%Headw4 = HeadfromPotential(k,H,b,real(Omega4))


%%%Analysis of change in alpha

% alphdeg = alpha*180/pi;
% %alphadeg = alphdeg + 5
% alphadeg = alphdeg - 26
% alpha = alphadeg*pi/180;

%%%Analysis of change in Q0
% Q0 = Q0*0.87;
% Qw_total = 370*.8;
% Qw_indiv = 370/4;
% Qw = [.35*Qw_total, .40*Qw_total, .33*Qw_total, 0*Qw_total];
% wellLine2Start = complex(Project_1_datafile(62,1),Project_1_datafile(62,2));
% wellLine2End = complex(Project_1_datafile(61,1),Project_1_datafile(61,2));
% WellLine2Spaces = linspace(wellLine2End, wellLine2Start,4);
% wellSpacing3 = [wellSpacing(4:5),WellLine2Spaces(2:3)];
% figure;
% ContourMe_flow_net(-200,300,70,-400,100,70,@(z)OmegaAll(Qw,z,spaces,sigmas,Q0,alpha,C,wellSpacing3,rw),50);
% MakingtheFieldDynamic(-200,300,-400,100,Project_1_datafile);