function [k,G,p,c,Pb,Cb,Tb] =  parameterValues(x)

if x >= 0 && x <= 0.00166667
    k = 25;
    G = 0;
    p = 1200;
    c = 3300;
    Pb = 0;
    Cb = 0;
    Tb = 0;
elseif x > 0.00166667 && x <= 0.005
    k = 40;
    G = 0.0375;
    p = 1200;
    c = 3300;
    Pb = 1060;
    Cb = 3770;
    Tb = 310.15;
elseif x >0.005 && x <= 0.01
    k = 20;
    G = 0.0375;
    p = 1200;
    c = 3300;
    Pb = 1060;
    Cb = 3770;
    Tb = 310.15;

end