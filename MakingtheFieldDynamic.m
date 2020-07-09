function [  ] = MakingtheFieldDynamic( xmin, xmax, ymin, ymax, Project_1_datafile )
%MAKINGTHEFIELDDYNAMIC Creates a plot of the data from project 1.

%create a plot of all the elements given
well1 = Project_1_datafile(1,:);
well2 = Project_1_datafile(2,:);
linesinks = Project_1_datafile(3:56,:);
wellfield = Project_1_datafile(57:64,:);
hold off
hold on
plot(linesinks(:,1),linesinks(:,2),'b', 'LineWidth', 3);
plot(wellfield(:,1),wellfield(:,2),'k');
plot(well1(1,1),well1(1,2),'xr');
plot(well2(1,1),well2(1,2),'xr');
z1 = linesinks(1,1)+1i*linesinks(1,2);
z2 = linesinks(54,1)+1i*linesinks(54,2);
plot([1737.961;-999.755],[-1274.5;932.0827]);
axis([xmin xmax ymin ymax]);
%axis equal
hold off

end

