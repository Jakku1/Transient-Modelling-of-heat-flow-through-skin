function [D,lmda] =  laplaceParameterValues(x)

if x >= 0 && x < 0.00166667
    k = 25;
    p = 1200;
    c = 3300;
    D = k/(p*c);
    lmda = 0;
elseif x >= 0.00166667 && x < 0.005
    k = 40;
    G = 0.0375;
    p = 1200;
    c = 3300;
    D = k/(p*c);
    
    Pb = 1060;
    Cb = 3770;
    lmda = (G*Pb*Cb)/(p*c);
elseif x >=0.005 && x <= 0.01
    k = 20;
    G = 0.0375;
    p = 1200;
    c = 3300;
    D = k/(p*c);
    
    Pb = 1060;
    Cb = 3770;
    lmda = (G*Pb*Cb)/(p*c);

end