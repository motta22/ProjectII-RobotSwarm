clear
close all
clc

m=map();
filename=input('Insert the filename:','s');
m=m.loadMap(filename);
figure('units','normalized','outerposition',[0 0 1 1])
m=m.drawMap();

xlim([0 200]);
ylim([0 200]);
axis square
grid on

[x,y]=ginput(2);

rPos=[x(1) y(1)]';
rTheta=atan2(y(2)-y(1),x(2)-x(1));

%Wheels Properties
nW=2;
wPos=[0   0
      4.5 -4.5];
wTheta=[0 0];

wRad=[2 2];
wWid=[1.5 1.5];

%Sensors Properties
nS=3;
sPos=[5.2 6 5.2
      3   0 -3];
sTheta=[pi/6 0 -pi/6];
sLen=[2 2 2];
sWid=[1 1 1];
whiskersLen=[5 5 5];

%Platform Properties
platRad=6;

Robot=robot(rPos,rTheta,nW,wPos,wTheta,wRad,wWid,nS,sPos,sTheta,sLen,sWid,whiskersLen,platRad);
pose=Robot.getPose()

Robot=Robot.drawRobot();

T=0.1;
iterTime=0.01;
errorMaxPos=1e-1;
errorMaxAngle=1e-1;
vMax=5;
dist=50;
wMax=pi/10;
wheelsRad=2;
wheelsDist=9;


moveBack=1;
if(~moveBack)
    % Without move back after collision
    while(1)
        Robot=moveForward(Robot,m,dist,vMax,T,errorMaxPos,iterTime,wheelsRad,wheelsDist,1);
        Robot=rotateRobot(Robot,m,2*pi*rand(1,1)-pi,wMax,T,errorMaxAngle,iterTime,wheelsRad,wheelsDist);
    end
else
    %With move back after collision
    while(1)
        [Robot travDist]=moveForward(Robot,m,dist,vMax,T,errorMaxPos,iterTime,wheelsRad,wheelsDist,1);
        if(travDist>0 && travDist<5)
            Robot=moveForward(Robot,m,travDist,-vMax,T,errorMaxPos,iterTime,wheelsRad,wheelsDist,1);
        end
        if((travDist>0 && travDist>=5))
            Robot=moveForward(Robot,m,5,-vMax,T,errorMaxPos,iterTime,wheelsRad,wheelsDist,1);
        end
        Robot=rotateRobot(Robot,m,2*pi*rand(1,1)-pi,wMax,T,errorMaxAngle,iterTime,wheelsRad,wheelsDist);
    end
end