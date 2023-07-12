function DistArr=RobotDist(ROBO,i,nRobots)
    DistArr=zeros(1,nRobots-1);
    actualPoseMaster=ROBO(i).getPose();
    c=1;
    for j=1:1:nRobots
        if j~=i
        actualPose=ROBO(j).getPose();
        Difx=abs(actualPoseMaster(1,1)-actualPose(1,1));
        Dify=abs(actualPoseMaster(2,1)-actualPose(2,1));
        DistArr(c)=sqrt((Difx*Difx)+(Dify*Dify));
        c=c+1;
        end
        
    end
end