function pose=nextPose(T,w,wRobot,poseRobot,wheelsRadius,wheelsDistance)
     pose=[poseRobot(1)+(T*wheelsRadius*((w(2)+w(1))/2))*cos(poseRobot(3)+(wRobot*T/2))
           poseRobot(2)+(T*wheelsRadius*((w(2)+w(1))/2))*sin(poseRobot(3)+(wRobot*T/2))
           poseRobot(3)+(T*wheelsRadius*(w(2)-w(1)))/wheelsDistance];
end