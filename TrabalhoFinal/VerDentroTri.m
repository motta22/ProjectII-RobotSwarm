function [found] = VerDentroTri( cor1,cor2,cor3,cor4)
    P1=cor1;
    P2=cor2;
    P3=cor3;
    xx=(P1(1,1)+P2(1,1)+P3(1,1))/3;
    yy=(P1(1,2)+P2(1,2)+P3(1,2))/3;
    Pxy=[xx yy];
    found=0;
    v1 = f_same_side_point( P1,P2,Pxy,cor4);
    v2 = f_same_side_point( P2,P3,Pxy,cor4);
    v3 = f_same_side_point( P3,P1,Pxy,cor4);
    if v1
        if v2
            if v3
                found=1;
            end
        end
    end
end

function [ res ] = f_same_side_point( cor1,cor2,cor3,cor4)

    x11=cor1(1,1);
    x12=cor2(1,1);
    y11=cor1(1,2);
    y12=cor2(1,2);
    m1=(y11-y12)/(x11-x12);

    x2=cor3(1,1);
    y2=cor3(1,2);

    x3=cor4(1,1);
    y3=cor4(1,2);
    b1=y11-x11*m1;
 
    m2=m1;
    m3=m1;
    b2=y2-m2*x2;
    b3=y3-m3*x3;
    rr=0;
    if b1>=b2
        if b1>=b3
            rr=1;
        end
    end
    if b1<=b2
        if b1<=b3
            rr=1;
        end
    end
    res=rr;
end
