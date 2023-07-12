function vetorP=CalcFormacao(ROBO,nRobots,master)
    global formacao
    vetorP=zeros(3,nRobots);
    PoseMaster=ROBO(master).getPose();
    c=1;
    d=1;
    cont=1;
    if formacao==1
        dist=135;
        theta=PoseMaster(3);
        for i=1:nRobots
            if i~=master
                vetorP(:,i)=PoseMaster-[c*dist*cos(theta) c*dist*sin(theta) 0]';
                c=c+1;
            end
        end
    end
    if formacao==2
        dist=135;
        theta=PoseMaster(3);
        for i=1:nRobots
            if i~=master
                if mod(nRobots,2)==0
                    if mod(i,2)==0
                        vetorP(:,i)=PoseMaster-[c*dist*cos(-(pi/2-theta)) c*dist*sin(-(pi/2-theta)) 0]';
                        c=c+1;
                    else
                        vetorP(:,i)=PoseMaster+[d*dist*cos(-(pi/2-theta)) d*dist*sin(-(pi/2-theta)) 0]';
                        d=d+1;
                    end
                else
                    if mod(cont,2)==0
                        vetorP(:,i)=PoseMaster-[c*dist*cos(-(pi/2-theta)) c*dist*sin(-(pi/2-theta)) 0]';
                        c=c+1;
                        cont=cont+1;
                    else
                        vetorP(:,i)=PoseMaster+[d*dist*cos(-(pi/2-theta)) d*dist*sin(-(pi/2-theta)) 0]';
                        d=d+1;
                        cont=cont+1;
                    end
                end
            end
        end
    end
end