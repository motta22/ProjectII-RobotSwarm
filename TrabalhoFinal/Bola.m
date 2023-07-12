classdef Bola
    properties
        worldTBola
        %Platform properties
        platformRadius
        hPlatform
    end
    methods
        function r=Bola(rPos,rTheta,platRad)
            
            r.worldTBola=[cos(rTheta) -sin(rTheta) rPos(1)
                           sin(rTheta) cos(rTheta)  rPos(2)
                           1           1            1];
        
                       
            r.platformRadius=platRad;
            
            r.hPlatform=[];
        end
        
        function rReturn=drawBola(r)
            
            hold on
            
            %draw platform
            [x,y]=pol2cart(linspace(0,2*pi,36),r.platformRadius*ones(1,36));
            if(size(r.hPlatform,1)==0)
                r.hPlatform=fill(r.worldTBola(1,3)+x,r.worldTBola(2,3)+y,'r');
            else
                r.hPlatform.XData=r.worldTBola(1,3)+x;
                r.hPlatform.YData=r.worldTBola(2,3)+y;
            end
            
            hold off
            
            rReturn=r;
        end
        
        function pose=getPose(r)
            pose=[r.worldTBola(1,3)
                  r.worldTBola(2,3)
                  atan2(r.worldTBola(2,1),r.worldTBola(1,1))];
        end
        
        function rReturn=setPose(r,pose)
            r.worldTBola=[cos(pose(3)) -sin(pose(3)) pose(1)
                           sin(pose(3)) cos(pose(3))  pose(2)
                           0            0             1];
            rReturn=r;
        end
        
        function rReturn=ChangeTheta(r, theta,rPos)
           r.worldTBola=[cos(theta) -sin(theta) rPos(1)
                           sin(theta) cos(theta)  rPos(2)
                           1           1            1]; 
           rReturn=r;
        end
    end
end
