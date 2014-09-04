function AnimationPlot = PositionAnimation(i, Pos, Ori, EndTime, h, MotorSpeeds) 
%#codegen
%clf;
%close;
%global AnimationPlot;
%NoSteps = ProcessFrequency*EndTime;
%global MotorLocation;
%i = 1;
%set up axis for animation
global ProcessFrequency;
global PlotMatrix;
%{
if min(Pos(:,1)) == max(Pos(:,1))
    xmin = min(Pos(:,1))-1;
    xmax = max(Pos(:,1))+1;
else
    xmin = min(Pos(:,1));
    xmax = max(Pos(:,1));
end

if min(Pos(:,2)) == max(Pos(:,2))
    ymin = min(Pos(:,2))-1;
    ymax = max(Pos(:,2))+1;
else
    ymin = min(Pos(:,2));
    ymax = max(Pos(:,2));
end

if min(Pos(:,3))== max(Pos(:,3))
    zmin = min(Pos(:,3))-1;
    zmax = max(Pos(:,3))+1;
else
    zmin = min(Pos(:,3));
    zmax = max(Pos(:,3));
end


xlen = abs(xmax-xmin)/20;
ylen = abs(ymax-ymin)/20;
zlen = abs(zmax-zmin)/20;
len = min([xlen,ylen, zlen]);
%}

len = 1;
xmin = -10;
xmax = 10;
ymin = -10;
ymax = 10;
zmin = -10;
zmax = 10;
hold on;
color = 'blue';
%Set Up Matrix to store Plots

%Make Graph Display Full Screen
%figure('units','normalized','outerposition',[0 0 1 1]);
figure(h)
%hold on;
    if Pos(3) > 0
        plot3(Pos(1), Pos(2), Pos(3), '-.xg');
        color = 'blue';
    else
        plot3(Pos(1), Pos(2), Pos(3), '-.xr');
        color = 'red';
    end
    
    
    %calculate the angle of the model
    Bank = Ori(1);
    Elevation = Ori(2);
    Heading = Ori(3);
    %set up the rotation matrix
    Rx = [1,0,0; 0, cos(Bank), -sin(Bank); 0, sin(Bank), cos(Bank)];
    Ry = [cos(Elevation), 0, sin(Elevation); 0,1,0; -sin(Elevation),0,cos(Elevation)];
    Rz = [cos(Heading), -sin(Heading),0; sin(Heading), cos(Heading),0;0,0,1];
    Rcombined = Rz*Ry*Rx;
    xOri = [1,0,0]*Rcombined;
    yOri = [0,1,0]*Rcombined;
    zOri = [0,0,1]*Rcombined;
    
    %{
    %DEBUG WARNINGS ONLY
    if (dot(zOri, xOri)) ~= 0
        'Warning z and x not orththoganal PRE'
        i*(EndTime/NoTimeSteps)
    end
    if (dot(zOri, yOri)) ~= 0
        'Warning z and y not orththoganal PRE'
        i*(EndTime/NoTimeSteps)
    end
    %}
    %normalize the vectors and convert to tenth scale
    xOri = (xOri/norm(xOri))*len;
    yOri = (yOri/norm(yOri))*len;
    zOri = (zOri/norm(zOri))*len;
    
    %{
    %DEBUG WARNINGS ONLY
    if (dot(zOri, xOri)) ~= 0
        'Warning z and x not orththoganal POST'
    end
    if (dot(zOri, yOri)) ~= 0
        'Warning z and y not orththoganal POST'
    end
    %}
    
    hold on;
    
    if i > 1
        delete(PlotMatrix((i-1), 1));
        delete(PlotMatrix((i-1), 2));
        delete(PlotMatrix((i-1), 3));
        delete(PlotMatrix((i-1), 4));
        delete(PlotMatrix((i-1), 5));
    end
    
    
    PlotMatrix(i, 1) = quiver3(Pos(1), Pos(2), Pos(3), xOri(1), xOri(2), xOri(3), color);
    PlotMatrix(i, 2) = quiver3(Pos(1), Pos(2), Pos(3), -xOri(1), -xOri(2), -xOri(3), color);
    PlotMatrix(i, 3) = quiver3(Pos(1), Pos(2), Pos(3), yOri(1), yOri(2), yOri(3), color);
    PlotMatrix(i, 4) = quiver3(Pos(1), Pos(2), Pos(3), -yOri(1), -yOri(2), -yOri(3), color);
    PlotMatrix(i, 5) = quiver3(Pos(1), Pos(2), Pos(3), zOri(1), zOri(2), zOri(3));
    currentTime = i/ProcessFrequency;
    title(['Quadrotor Flight Path Time: ',  num2str(currentTime), ' Motor Speeds: ', num2str(MotorSpeeds(1))]);
    xlabel('X Position');
    ylabel('Y Position');
    zlabel('Z Position');
    view(45,45);
    axis([xmin,xmax,ymin,ymax,zmin,zmax]);
    grid on
    AnimationPlot = h;

end
