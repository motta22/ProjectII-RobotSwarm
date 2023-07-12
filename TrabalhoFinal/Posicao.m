function [distancia] = Posicao(nRobots,finalPoseM,finalPoseS,master)
contador=0;
if rem(contador,5) == 0
    fprintf('Master:X:%s Y:%s\n',finalPoseM(1),finalPoseM(2));
    for i= 1:nRobots
        if i~= master
            fprintf('Slave(%d): X:%s Y:%s\n',i,finalPoseS(1),finalPoseS(2));
            X=[finalPoseM(1),finalPoseM(2);finalPoseS(1),finalPoseS(2)];
            distancia=pdist(X,'euclidean');
            fprintf('Distancia: %s\n',distancia);
        end
    end
end

end