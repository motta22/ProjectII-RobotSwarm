function [ROBO,found,finalPoseM,finalPoseS] = MoveRobot(ROBO,T,nRobots,vMax,wMax,wheelsRad,wheelsDist,iterTime,found,master)

[ROBO,found,finalPoseM] = ControlMaster(ROBO,T,nRobots,vMax,wMax,wheelsRad,wheelsDist,iterTime,found,master);
[ROBO,finalPoseS] = ControlSlave(ROBO,T,nRobots,vMax,wMax,wheelsRad,wheelsDist,iterTime,master);

end

function [ROBO,finalPoseS] = ControlSlave(ROBO,T,nRobots,vMax,wMax,wheelsRad,wheelsDist,iterTime,master)
global formacao
actualPose=zeros(3,nRobots);
finalPoseS=zeros(3,nRobots);
w=zeros(2,nRobots);
fPose=zeros(2,nRobots);
vRobot=zeros(nRobots);
wRobot=zeros(nRobots);
error=zeros(nRobots);
vetorP=CalcFormacao(ROBO,nRobots,master);
if formacao == 1
    error1=90;
    error2=5;
else
    if formacao == 2
    error1=5;
    error2=5;
    end
end
for i=1:nRobots
    
    if i~=master
        [frx,fry]=CF(ROBO,vetorP(:,i),nRobots);
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
        
        PosMaster=ROBO(master).getPose();
        if PosMaster(3)<2*pi/6 && PosMaster(3)>-2*pi/6
            if abs(error(i))<=error1
                finalPoseS(:,i)=ROBO(i).getPose();
                ROBO(i)=ROBO(i).setPose(finalPoseS(:,i));
                errorT=PosMaster(3)-finalPoseS(3,i);
                if finalPoseS(3,i) ~= PosMaster(3) && abs(errorT) > 0.10
                    finalPoseS(:,i)=nextPose(T,[-0.25 0.25],PosMaster(3),actualPose(:,i),wheelsRad,wheelsDist);
                    ROBO(i)=ROBO(i).setPose(finalPoseS(:,i));
                    ROBO(i)=ROBO(i).drawRobot();
                else
                    ROBO(i)=ROBO(i).drawRobot();
                end
                
            else
                w(:,i)=velRobot2velWheels(vRobot(i),wRobot(i),wheelsRad,wheelsDist);
                finalPoseS(:,i)=nextPose(T,w(:,i),wRobot(i),actualPose(:,i),wheelsRad,wheelsDist);
                ROBO(i)=ROBO(i).setPose(finalPoseS(:,i));
                ROBO(i)=ROBO(i).drawRobot();
            end
        else
            if abs(error(i))<=error2
                finalPoseS(:,i)=ROBO(i).getPose();
                ROBO(i)=ROBO(i).setPose(finalPoseS(:,i));
                errorT=PosMaster(3)-finalPoseS(3,i);
                if finalPoseS(3,i) ~= PosMaster(3) && abs(errorT) > 0.10
                    finalPoseS(:,i)=nextPose(T,[-0.25 0.25],PosMaster(3),actualPose(:,i),wheelsRad,wheelsDist);
                    ROBO(i)=ROBO(i).setPose(finalPoseS(:,i));
                    ROBO(i)=ROBO(i).drawRobot();
                else
                    ROBO(i)=ROBO(i).drawRobot();
                end
                
            else
                w(:,i)=velRobot2velWheels(vRobot(i),wRobot(i),wheelsRad,wheelsDist);
                finalPoseS(:,i)=nextPose(T,w(:,i),wRobot(i),actualPose(:,i),wheelsRad,wheelsDist);
                ROBO(i)=ROBO(i).setPose(finalPoseS(:,i));
                ROBO(i)=ROBO(i).drawRobot();
            end
        end
        
        pause(iterTime/nRobots)
    end
end
end

function [ROBO,found,finalPoseM] = ControlMaster(ROBO,T,nRobots,vMax,wMax,wheelsRad,wheelsDist,iterTime,found,master)
global Bola1
global Comando
w=zeros;

PoseatualBola=Bola1.getPose();
actualPose=ROBO(master).getPose();
[vRobot, wRobot, error]=Velocidades(PoseatualBola,actualPose);

if(abs(vRobot)>abs(vMax))
    vRobot=vMax;
end

if(abs(wRobot)>wMax)
    wRobot=sign(wRobot)*wMax;
end

if Comando == "5"
    finalPoseM=actualPose;
else
    w=velRobot2velWheels(vRobot,wRobot,wheelsRad,wheelsDist);
    finalPoseM=nextPose(T,w,wRobot,actualPose,wheelsRad,wheelsDist);
end

ROBO(master)=ROBO(master).setPose(finalPoseM);
ROBO(master)=ROBO(master).drawRobot();
pause(iterTime/nRobots)

PoseSens=ROBO(master).PoseSens();
Pose1Ponto=PoseSens(1:2,1)';
Pose2Ponto=PoseSens(1:2,2)';
Pose3Ponto=PoseSens(1:2,3)';
PoseBola1=PoseatualBola(1:2)';

found=VerDentroTri(Pose1Ponto,Pose2Ponto,Pose3Ponto,PoseBola1);
end