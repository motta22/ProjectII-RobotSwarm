clear
close all
clc

%criação do mapa

m=map();
filename=input('Insert the filename:','s'); %carrega o nome do mapa
nRobots=input('Numero de robos: '); % number of robots

m=m.loadMap(filename);
figure('units','normalized','outerposition',[0 0 1 1])
m=m.drawMap(); %desenha o mapa

xlim([0 200]); %dimensão do mapa
ylim([0 200]);
axis square    %formato do mapa
grid on        %definição do mapa

%rPos=zeros(nRobots,2);
%rTheta=zeros(nRobots,2);

for i=1:nRobots
    [x,y]=ginput(1); %posição do robo
    
    rPos=[x(1) y(1)];
    
    rTheta=atan2(y(1),x(1)); 

    %Wheels Properties
    nW=2;
    wPos=[0   0
          4.5 -4.5];
    wTheta=[0 0];

    wRad=[2 2];
    wWid=[1.5 1.5];

    %Sensors Properties
    nS=1;
    sPos=[5.2 6 5.2
          3   0 -3];
    sTheta=[pi/6 0 -pi/6];
    sLen=[2 2 2];
    sWid=[1 1 1];
    whiskersLen=[5 5 5];

    %Platform Properties
    platRad=6;
        
    ROBO(i)=robot(rPos,rTheta,nW,wPos,wTheta,wRad,wWid,nS,sPos,sTheta,sLen,sWid,whiskersLen,platRad);
    pose=ROBO(i).getPose();

    ROBO(i)=ROBO(i).drawRobot();
    
end

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
        for i=1:nRobots
            ROBO(i)=moveForward(ROBO(i),m,dist,vMax,T,errorMaxPos,iterTime,wheelsRad,wheelsDist,1);
            ROBO(i)=rotateRobot(ROBO(i),m,2*pi*rand(1,1)-pi,wMax,T,errorMaxAngle,iterTime,wheelsRad,wheelsDist);
        end
    end
else
    %With move back after collision
    while(1)
        for i=1:nRobots
            [ROBO(i), travDist]=moveForward(ROBO(i),m,dist,vMax,T,errorMaxPos,iterTime,wheelsRad,wheelsDist,1);
            if(travDist>0 && travDist<5)
                ROBO(i)=moveForward(ROBO(i),m,travDist,-vMax,T,errorMaxPos,iterTime,wheelsRad,wheelsDist,1);
            end
            if((travDist>0 && travDist>=5))
                ROBO(i)=moveForward(ROBO(i),m,5,-vMax,T,errorMaxPos,iterTime,wheelsRad,wheelsDist,1);
            end
            ROBO(i)=rotateRobot(ROBO(i),m,2*pi*rand(1,1)-pi,wMax,T,errorMaxAngle,iterTime,wheelsRad,wheelsDist);
        end
    end
end

