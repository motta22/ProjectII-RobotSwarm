function Bola1 =moveBola(Bola1,vMax,dist,iterTime,nRobots)

    global Comando
    global Cima
    global Direita
    global Esquerda
    global Baixo
    
    rTheta=Cima;
    
    vMax=vMax+1.5;

    if Comando == "1"
        if rTheta ~= Cima
            actualPose1=Bola1.getPose();
            Bola1=Bola1.ChangeTheta(Cima,actualPose1);
            Bola1=Bola1.drawBola();
            rTheta=Cima;
            pause(iterTime/nRobots);
        end
        actualPose=Bola1.getPose();
        initialPose=actualPose;
        finalPose=actualPose+[sign(vMax)*dist*cos(Cima) sign(vMax)*dist*sin(Cima) 0]';
        Bola1=Bola1.setPose(finalPose);
        Bola1=Bola1.drawBola();
    end
    if Comando == "2"
        if rTheta ~= Baixo
            actualPose1=Bola1.getPose();
            Bola1=Bola1.ChangeTheta(Baixo,actualPose1);
            Bola1=Bola1.drawBola();
            rTheta=Baixo;
            pause(iterTime/nRobots);
        end
        actualPose=Bola1.getPose();
        initialPose=actualPose;
        finalPose=actualPose+[sign(vMax)*dist*cos(Baixo) sign(vMax)*dist*sin(Baixo) 0]';
        Bola1=Bola1.setPose(finalPose);
        Bola1=Bola1.drawBola();
    end
    if Comando == "3"
        if rTheta ~= Esquerda
            actualPose1=Bola1.getPose();
            Bola1=Bola1.ChangeTheta(Esquerda,actualPose1);
            Bola1=Bola1.drawBola();
            rTheta=Esquerda;
            pause(iterTime/nRobots);
        end
        actualPose=Bola1.getPose();
        initialPose=actualPose;
        finalPose=actualPose+[sign(vMax)*dist*cos(Esquerda) sign(vMax)*dist*sin(Esquerda) 0]';
        Bola1=Bola1.setPose(finalPose);
        Bola1=Bola1.drawBola();
    end
    if Comando == "4"
        if rTheta ~= Direita
            actualPose1=Bola1.getPose();
            Bola1=Bola1.ChangeTheta(Direita,actualPose1);
            Bola1=Bola1.drawBola();
            rTheta=Direita;
            pause(iterTime/nRobots);
        end
        actualPose=Bola1.getPose();
        initialPose=actualPose;
        finalPose=actualPose+[sign(vMax)*dist*cos(Direita) sign(vMax)*dist*sin(Direita) 0]';
        Bola1=Bola1.setPose(finalPose);
        Bola1=Bola1.drawBola();
    end
    fprintf('char nom main: %c \n',Comando)
    if Comando == "5"
        actualPose=Bola1.getPose();
        finalPose=actualPose;
        Bola1=Bola1.setPose(finalPose);
        Bola1=Bola1.drawBola();
    end
    pause(iterTime/nRobots);
end