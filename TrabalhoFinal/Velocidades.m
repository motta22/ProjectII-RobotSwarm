function[v,w,error]=Velocidades(posgoal,pos)
    
Kv=10;
Ks=5;

error=norm(posgoal(1:2)-pos(1:2));

phigoal=atan2(posgoal(2)-pos(2),posgoal(1)-pos(1));
phi=atan2(sin(phigoal-pos(3)),cos(phigoal-pos(3)));

v=Kv*error;
w=Ks*phi;

end