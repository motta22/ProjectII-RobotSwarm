function [ROBO,found,master]= MoveRandom(ROBO,T,nRobots,vMax,wMax,wheelsRad,wheelsDist,iterTime,found,master,m)
global Bola1
actualPose=zeros(3,nRobots);
finalPose=zeros(3,nRobots);
fPose=zeros(2,nRobots);
vRobot=zeros(nRobots);
wRobot=zeros(nRobots);
error=zeros(nRobots);
w=zeros(2,nRobots);

actualBola1Pose=Bola1.getPose();

for i=1:nRobots
    PoseSens=ROBO(i).PoseSens();
    Pose1Ponto=PoseSens(1:2,1)';
    Pose2Ponto=PoseSens(1:2,2)';
    Pose3Ponto=PoseSens(1:2,3)';
    PoseBola1=actualBola1Pose(1:2)';
    
    found=VerDentroTri(Pose1Ponto,Pose2Ponto,Pose3Ponto,PoseBola1);
    
    if found==1
        master=i;
        break
    else
        found=0;
    end
    
    PoseatualRandom=randi([0 650],1,2);
    [frx,fry]=CF(ROBO,PoseatualRandom,nRobots);
    
    actualPose(:,i)=ROBO(i).getPose();
    fPose(1,i)=actualPose(1,i)+frx(i);
    fPose(2,i)=actualPose(2,i)+fry(i);
    [vRobot(i), wRobot(i), error(i)]=Velocidades(fPose(:,i),actualPose(:,i));
    
    if(abs(vRobot(i))>abs(vMax))
        vRobot(i)=vMax;
    end
    
    if(abs(wRobot(i))>wMax)
        wRobot(i)=sign(wRobot(i))*wMax;
    end
    
    w(:,i)=velRobot2velWheels(vRobot(i),wRobot(i),wheelsRad,wheelsDist);
    finalPose(:,i)=nextPose(T,w(:,i),wRobot(i),actualPose(:,i),wheelsRad,wheelsDist);
    ROBO(i)=ROBO(i).setPose(finalPose(:,i));
    
    
    ROBO(i)=ROBO(i).drawRobot();
    pause(iterTime/nRobots)
    
    
    
end
end