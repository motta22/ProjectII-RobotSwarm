function [FRX,FRY]=CF(ROBO,BolaPose,nRobots)
    [fax,fay]=calForcAtrac(ROBO,nRobots,BolaPose);
    [frx,fry]=calForcRep(ROBO,nRobots);
    FRX=zeros(nRobots,1);
    FRY=zeros(nRobots,1);
    for i=1:1:nRobots
       FRX(i)= fax(i)+sum(frx(i,:));
       FRY(i)= fay(i)+sum(fry(i,:));
    end
end

function [forcax,forcay]=calForcAtrac(ROBO,nRobots,BolaPose)
    forcax=zeros(nRobots,1);
    forcay=zeros(nRobots,1);
    posegoal=BolaPose;
    actualPose=zeros(nRobots,3);
    
    versorx=zeros(nRobots,1);
    versory=zeros(nRobots,1);
    const=500;
    
    for i=1:1:nRobots
        actualPose(i,:)=ROBO(i).getPose();
        error(i)=norm(posegoal(1:2)-actualPose(i,1:2));
        versorx(i)=(posegoal(1)-actualPose(i,1))/error(i);
        versory(i)=(posegoal(2)-actualPose(i,2))/error(i);
        forcax(i)=versorx(i)*const;
        forcay(i)=versory(i)*const;
    end
    
end

function [fox,foy]=calForcRep(ROBO,nRobots)
    const=-4500;
    
    fox=zeros(nRobots,nRobots-1);
    foy=zeros(nRobots,nRobots-1);
    versorx=zeros(nRobots,1);
    versory=zeros(nRobots,1);
    
    for i=1:1:nRobots
        DistArr=RobotDist(ROBO,i,nRobots);
        c=1;
        actualPose(i,:)=ROBO(i).getPose();
        for j=1:1:nRobots
            if j~=i
            a=ROBO(j).getPose();
            versorx(i)=(a(1)-actualPose(i,1))/(DistArr(c));
            versory(i)=(a(2)-actualPose(i,2))/(DistArr(c));
            fox(i,j)=versorx(i)*(const/DistArr(c));
            foy(i,j)=versory(i)*(const/DistArr(c));
            
            c=c+1; 
            end
            
        end
    end
end