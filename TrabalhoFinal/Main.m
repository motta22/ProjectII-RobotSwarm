clear
close all
clc
global Comando
global Bola1
global Cima
global Direita
global Esquerda
global Baixo
global formacao


Comando="5";

comun()

Cima=pi/2;
Direita=0;
Esquerda=pi;
Baixo=-pi/2;

found=0;
master=0;
contador=0;

%criação do mapa

m=map();
filename=input('Insert the filename:','s'); %carrega o nome do mapa
nRobots=input('Numero de robos: '); % number of robots
formacao=input('Numero de forma��o (1 ou 2): ');


m=m.loadMap(filename);
figure('units','normalized','outerposition',[0 0 1 1])
m=m.drawMap(); %desenha o mapa

xlim([0 750]); %dimensão do mapa
ylim([0 750]);
axis square    %formato do mapa
grid on        %definição do mapa

% [x,y]=ginput(1); %posição do bola
%
% rPos=[x(1) y(1)];
%
% rTheta=Cima;
%
% %Platform Properties
% platRad=3;
%
% Bola1=Bola(rPos,rTheta,platRad);
% pose=Bola1.getPose();
% Bola1=Bola1.drawBola;
%
% pause(1);

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
    sPos=[ 6
        0];
    sTheta=(0);
    sLen=(2);
    sWid=(1);
    whiskersLen=(20);
    
    
    %Platform Properties
    platRad=6;
    
    ROBO(i)=robot(rPos,rTheta,nW,wPos,wTheta,wRad,wWid,nS,sPos,sTheta,sLen,sWid,whiskersLen,platRad);
    pose=ROBO(i).getPose();
    
    ROBO(i)=ROBO(i).drawRobot();
end

[x,y]=ginput(1); %posição do bola

rPos1=[x(1) y(1)];

rTheta=Cima;

%Platform Properties
platRad=3;

Bola1=Bola(rPos1,rTheta,platRad);
pose1=Bola1.getPose();
Bola1=Bola1.drawBola;

pause(1);

vMax=3.5;
wMax=pi/3;
dist=2;
flag=0;
T=0.5;
wheelsRad=2;
wheelsDist=9;
iterTime=0.01;

while flag==0
    while found==0
        [ROBO,found,master]=MoveRandom(ROBO,T,nRobots,vMax,wMax,wheelsRad,wheelsDist,iterTime,found,master,m);
        Bola1=moveBola(Bola1,vMax,dist,iterTime,nRobots);
    end
    while found==1
        [ROBO,found,finalPoseM,finalPoseS]=MoveRobot(ROBO,T,nRobots,vMax,wMax,wheelsRad,wheelsDist,iterTime,found,master);
        Posicao(nRobots,finalPoseM,finalPoseS,master);
        Bola1=moveBola(Bola1,vMax,dist,iterTime,nRobots);
    end
end




