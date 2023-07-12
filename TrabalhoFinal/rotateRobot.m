function Robot=rotateRobot(Robot,m,angle,wMax,T,errorMax,iterTime,wheelsRad,wheelsDist)
    
    Kp=wMax/(0.5*abs(angle));
    
    actualPose=Robot.getPose();
    finalPose=actualPose+[0 0 angle]';
    
    error=1;
    Robot=Robot.drawRobot();
    while(abs(error)>errorMax)
        
        error=finalPose(3)-actualPose(3);
        
        wRobot=Kp*error;
        if(abs(wRobot)>wMax)
            wRobot=sign(angle)*wMax;
        end
        
        w=velRobot2velWheels(0,wRobot,wheelsRad,wheelsDist);
        lastPose=actualPose;
        actualPose=nextPose(T,w,wRobot,actualPose,wheelsRad,wheelsDist);
        
        %=========Colision Verification===================================%
        Robot=Robot.setPose(actualPose);
        sensors=Robot.readSensor(m);
        for i=1:size(sensors,2)
            if(sensors(i))
                Robot=Robot.setPose(lastPose);
                return
            end
        end
        %=================================================================%        
        Robot=Robot.drawRobot();
        pause(iterTime);
    end

end