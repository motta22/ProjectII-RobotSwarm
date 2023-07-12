function [w phi]=invKineDifDrive(actualPose,finalPose,T,wheelsRadius,wheelsDistance)
    difPose=(finalPose-actualPose)/T;
    phi=-atan2(-difPose(1),difPose(2));
    difPose(3)=(phi-actualPose(3))/T;
    w=[difPose(1)/(wheelsRadius*sin(phi))-wheelsDistance*difPose(3)/(2*wheelsRadius)
       difPose(1)/(wheelsRadius*sin(phi))+wheelsDistance*difPose(3)/(2*wheelsRadius)];
end