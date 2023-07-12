
%Wheels Properties
nW=2;
wPos=[0   0
      4.5 -4.5];
wTheta=[0 0];
wRad=[2 2];
wWid=[1.5 1.5];
wheelsRadius=2;
wheelsDistance=9;

%Sensors Properties
nS=3;
sPos=[6 5.2 5.2
      0 3   -3];
sTheta=[0 pi/6 -pi/6];
sLen=[2 2 2];
sWid=[1 1 1];
whiskersLen=[5 5 5];

%Platform Properties
platRad=6;

T=0.1;


%% ===============Linear Movement with vRobot = accel*t================= %%
pause
close
clc

figure('units','normalized','outerposition',[0 0 1 1])

subplot(1,2,1)
xlim([0 200]);
ylim([0 200]);
axis square
grid on

subplot(4,2,2)
hvRobot=plot(0,0);
title('Linear Velocity of Robot')
xlim([0 30]);
ylim([0 5]);
subplot(4,2,4)
hwRobot=plot(0,0);
title('Angular Velocity of Robot')
xlim([0 30]);
ylim([0 5]);
subplot(4,2,6)
hwLeft=plot(0,0);
title('Angular Velocity of Left Wheel')
xlim([0 30]);
ylim([0 5]);
subplot(4,2,8)
hwRight=plot(0,0);
title('Angular Velocity of Right Wheel')
xlim([0 30]);
ylim([0 5]);

subplot(1,2,1)
title('Choose Position and Orientation')
[x,y]=ginput(2);
rPos=[x(1) y(1)]';
rTheta=atan2(y(2)-y(1),x(2)-x(1));

Robot=robot(rPos,rTheta,nW,wPos,wTheta,wRad,wWid,nS,sPos,sTheta,sLen,sWid,whiskersLen,platRad);
pose=Robot.getPose();
Robot=Robot.drawRobot();

accel=0.1;

hold on
subplot(1,2,1)
title(['Linear Movement with vRobot = ' num2str(accel) 't'])
h=plot(pose(1),pose(2),'--k');
hold off

for i=1:300
    vRobot=accel*(i-1)/10;
    wRobot=0;
    w=velRobot2velWheels(vRobot,wRobot,2,9);
    pose=nextPose(T,w,wRobot,pose,2,9);
    Robot=Robot.setPose(pose);
    
    Robot=Robot.drawRobot();
    h.XData=[h.XData pose(1)];
    h.YData=[h.YData pose(2)];
    hvRobot.XData=[hvRobot.XData (i-1)/10];
    hvRobot.YData=[hvRobot.YData vRobot];
    hwRobot.XData=[hwRobot.XData (i-1)/10];
    hwRobot.YData=[hwRobot.YData wRobot];
    hwLeft.XData=[hwLeft.XData (i-1)/10];
    hwLeft.YData=[hwLeft.YData w(1)];
    hwRight.XData=[hwRight.XData (i-1)/10];
    hwRight.YData=[hwRight.YData w(2)];
    
    pause(0.1)
end

%=========================================================================%

%% ================Rotation with wRobot = sin(radfreq*t)================ %%
pause
close
clc

figure('units','normalized','outerposition',[0 0 1 1])

subplot(1,2,1)
xlim([0 200]);
ylim([0 200]);
axis square
grid on

subplot(4,2,2)
hvRobot=plot(0,0);
title('Linear Velocity of Robot')
xlim([0 30]);
ylim([0 5]);
subplot(4,2,4)
hwRobot=plot(0,0);
title('Angular Velocity of Robot')
xlim([0 30]);
ylim([-3 3]);
subplot(4,2,6)
hwLeft=plot(0,0);
title('Angular Velocity of Left Wheel')
xlim([0 30]);
ylim([-3 3]);
subplot(4,2,8)
hwRight=plot(0,0);
title('Angular Velocity of Right Wheel')
xlim([0 30]);
ylim([-3 3]);

subplot(1,2,1)
title('Choose Position and Orientation')
[x,y]=ginput(2);
rPos=[x(1) y(1)]';
rTheta=atan2(y(2)-y(1),x(2)-x(1));

Robot=robot(rPos,rTheta,nW,wPos,wTheta,wRad,wWid,nS,sPos,sTheta,sLen,sWid,whiskersLen,platRad);
pose=Robot.getPose();
Robot=Robot.drawRobot();

radfreq=pi;

hold on
subplot(1,2,1)
title(['Rotation with wRobot = sin(' num2str(radfreq) 't)'])
h=plot(pose(1),pose(2),'--k');
hold off

for i=1:300
    vRobot=0;
    wRobot=sin(radfreq*(i-1)/10);
    w=velRobot2velWheels(vRobot,wRobot,2,9);
    pose=nextPose(T,w,wRobot,pose,2,9);
    Robot=Robot.setPose(pose);
    
    Robot=Robot.drawRobot();
    h.XData=[h.XData pose(1)];
    h.YData=[h.YData pose(2)];
    hvRobot.XData=[hvRobot.XData (i-1)/10];
    hvRobot.YData=[hvRobot.YData vRobot];
    hwRobot.XData=[hwRobot.XData (i-1)/10];
    hwRobot.YData=[hwRobot.YData wRobot];
    hwLeft.XData=[hwLeft.XData (i-1)/10];
    hwLeft.YData=[hwLeft.YData w(1)];
    hwRight.XData=[hwRight.XData (i-1)/10];
    hwRight.YData=[hwRight.YData w(2)];
    
    pause(0.1)
end

%=========================================================================%

%% =======Movement with vRobot = accel*t wRobot = sin(radfreq*t)======== %%
pause
close
clc

figure('units','normalized','outerposition',[0 0 1 1])

subplot(1,2,1)
xlim([0 200]);
ylim([0 200]);
axis square
grid on

subplot(4,2,2)
hvRobot=plot(0,0);
title('Linear Velocity of Robot')
xlim([0 30]);
ylim([0 5]);
subplot(4,2,4)
hwRobot=plot(0,0);
title('Angular Velocity of Robot')
xlim([0 30]);
ylim([-5 5]);
subplot(4,2,6)
hwLeft=plot(0,0);
title('Angular Velocity of Left Wheel')
xlim([0 30]);
ylim([-5 5]);
subplot(4,2,8)
hwRight=plot(0,0);
title('Angular Velocity of Right Wheel')
xlim([0 30]);
ylim([-5 5]);

subplot(1,2,1)
title('Choose Position and Orientation')
[x,y]=ginput(2);
rPos=[x(1) y(1)]';
rTheta=atan2(y(2)-y(1),x(2)-x(1));

Robot=robot(rPos,rTheta,nW,wPos,wTheta,wRad,wWid,nS,sPos,sTheta,sLen,sWid,whiskersLen,platRad);
pose=Robot.getPose();
Robot=Robot.drawRobot();

accel=0.1;
radfreq=pi;

hold on
subplot(1,2,1)
title(['Movement with vRobot = ' num2str(accel) 't and wRobot = ' num2str(radfreq) 't'])
h=plot(pose(1),pose(2),'--k');
hold off

for i=1:300
    vRobot=accel*(i-1)/10;
    wRobot=sin(radfreq*(i-1)/10);
    w=velRobot2velWheels(vRobot,wRobot,2,9);
    pose=nextPose(T,w,wRobot,pose,2,9);
    Robot=Robot.setPose(pose);
    
    Robot=Robot.drawRobot();
    h.XData=[h.XData pose(1)];
    h.YData=[h.YData pose(2)];
    hvRobot.XData=[hvRobot.XData (i-1)/10];
    hvRobot.YData=[hvRobot.YData vRobot];
    hwRobot.XData=[hwRobot.XData (i-1)/10];
    hwRobot.YData=[hwRobot.YData wRobot];
    hwLeft.XData=[hwLeft.XData (i-1)/10];
    hwLeft.YData=[hwLeft.YData w(1)];
    hwRight.XData=[hwRight.XData (i-1)/10];
    hwRight.YData=[hwRight.YData w(2)];
    
    pause(0.1)
end

%=========================================================================%

%% =================Circular Path with Radius=curvRadius================ %%
pause
close
clc

figure('units','normalized','outerposition',[0 0 1 1])

subplot(1,2,1)
xlim([0 200]);
ylim([0 200]);
axis square
grid on

subplot(4,2,2)
hvRobot=plot(0,0);
title('Linear Velocity of Robot')
xlim([0 30]);
ylim([0 30]);
subplot(4,2,4)
hwRobot=plot(0,0);
title('Angular Velocity of Robot')
xlim([0 30]);
ylim([-5 5]);
subplot(4,2,6)
hwLeft=plot(0,0);
title('Angular Velocity of Left Wheel')
xlim([0 30]);
ylim([0 30]);
subplot(4,2,8)
hwRight=plot(0,0);
title('Angular Velocity of Right Wheel')
xlim([0 30]);
ylim([0 30]);

subplot(1,2,1)
title('Choose Position and Orientation')
[x,y]=ginput(2);
rPos=[x(1) y(1)]';
rTheta=atan2(y(2)-y(1),x(2)-x(1));

Robot=robot(rPos,rTheta,nW,wPos,wTheta,wRad,wWid,nS,sPos,sTheta,sLen,sWid,whiskersLen,platRad);
pose=Robot.getPose();
Robot=Robot.drawRobot();

curvRadius=40;
wRobot=2*pi/10;
vRobot=wRobot*curvRadius;

hold on
subplot(1,2,1)
title(['Circular Movement (R = ' num2str(curvRadius) ', w_{Robot} = ' num2str(wRobot) ', v_{Robot} = ' num2str(vRobot) ')'])
h=plot(pose(1),pose(2),'--k');
hold off

for i=1:300
    w=velRobot2velWheels(vRobot,wRobot,2,9);
    pose=nextPose(T,w,wRobot,pose,2,9);
    Robot=Robot.setPose(pose);
    
    Robot=Robot.drawRobot();
    h.XData=[h.XData pose(1)];
    h.YData=[h.YData pose(2)];
    hvRobot.XData=[hvRobot.XData (i-1)/10];
    hvRobot.YData=[hvRobot.YData vRobot];
    hwRobot.XData=[hwRobot.XData (i-1)/10];
    hwRobot.YData=[hwRobot.YData wRobot];
    hwLeft.XData=[hwLeft.XData (i-1)/10];
    hwLeft.YData=[hwLeft.YData w(1)];
    hwRight.XData=[hwRight.XData (i-1)/10];
    hwRight.YData=[hwRight.YData w(2)];
    
    pause(0.1)
end

%=========================================================================%


%% ===============Inverse Kinematics of Diferencial Robot=============== %%
pause
close
clc

figure('units','normalized','outerposition',[0 0 1 1])

xlim([0 200]);
ylim([0 200]);
axis square
grid on


title('Choose Position and Orientation')
[x,y]=ginput(2);
rPos=[x(1) y(1)]';
rTheta=atan2(y(2)-y(1),x(2)-x(1));

Robot=robot(rPos,rTheta,nW,wPos,wTheta,wRad,wWid,nS,sPos,sTheta,sLen,sWid,whiskersLen,platRad);
pose=Robot.getPose();
Robot=Robot.drawRobot();

hold on
h=plot(pose(1),pose(2),'--k');
hold off

R=50;
wRobot=0;

initialPose=pose;
NextPose=[R*cos(0) R*sin(0) 0]';
Kd=1.001;
title(['Circular Movement (R = ' num2str(R) ')with inverse kinematics'])
for i=1:300
    actualPose=NextPose;
    NextPose=[R*cos(i/10) R*sin(i/10) 0]';
    [w NextPose(3)]=invKineDifDrive(actualPose,NextPose,T,wheelsRadius,wheelsDistance);
    pose=nextPose(T,w,wheelsRadius*(w(2)-w(1))/wheelsDistance,pose,2,9);
    
    Robot=Robot.setPose(pose);
    Robot=Robot.drawRobot();
    
    h.XData=[h.XData pose(1)];
    h.YData=[h.YData pose(2)];
    pause(0.1)
end

%=========================================================================%

%% ===============Square path with side size equals to l================ %%
pause
close
clc

figure('units','normalized','outerposition',[0 0 1 1])

xlim([0 200]);
ylim([0 200]);
axis square
grid on


title('Choose Position and Orientation')
[x,y]=ginput(2);
rPos=[x(1) y(1)]';
rTheta=atan2(y(2)-y(1),x(2)-x(1));

Robot=robot(rPos,rTheta,nW,wPos,wTheta,wRad,wWid,nS,sPos,sTheta,sLen,sWid,whiskersLen,platRad);
pose=Robot.getPose();
Robot=Robot.drawRobot();

hold on
h=plot(pose(1),pose(2),'--k');
hold off

l=50;
title(['Square Movement (R = ' num2str(l) ')'])

m=map();
m=m.drawMap();

dist=l;
vMax=30;
angle=pi/2;
wMax=pi;
errorMaxPos=1e-1;
errorMaxAngle=1e-3;
T=0.1;
iterTime=0.1;
trace=1;

for i=1:3
    Robot=moveForward(Robot,m,dist,vMax,T,errorMaxPos,iterTime,wheelsRadius,wheelsDistance,trace);
    Robot=rotateRobot(Robot,m,angle,wMax,T,errorMaxAngle,iterTime,wheelsRadius,wheelsDistance);
    Robot=moveForward(Robot,m,dist,vMax,T,errorMaxPos,iterTime,wheelsRadius,wheelsDistance,trace);
    Robot=rotateRobot(Robot,m,angle,wMax,T,errorMaxAngle,iterTime,wheelsRadius,wheelsDistance);
    Robot=moveForward(Robot,m,dist,vMax,T,errorMaxPos,iterTime,wheelsRadius,wheelsDistance,trace);
    Robot=rotateRobot(Robot,m,angle,wMax,T,errorMaxAngle,iterTime,wheelsRadius,wheelsDistance);
    Robot=moveForward(Robot,m,dist,vMax,T,errorMaxPos,iterTime,wheelsRadius,wheelsDistance,trace);
    Robot=rotateRobot(Robot,m,angle,wMax,T,errorMaxAngle,iterTime,wheelsRadius,wheelsDistance);
end

%=========================================================================%