function damage = burnDamage(solutionMatrix, Boundary)

%solution matrix from the transient solver code is required and a character
%to determine the boundary to view the damage at. 'E' or 'D'

%select the correct column from the solutionMatrix 
switch Boundary
    case 'E'
        column = 1;
    case 'D'
        column = 2;
end

%initialise time variables
t = 50;

N = t/0.01;

%find the point in time where T first exceeds the burn temperature
for i = 1:N-1
    if solutionMatrix(i,column) >= 317.15
        tBurn = i;
        break
    end
end

%take only points that are above the burn temperature
tBurnMatrix = solutionMatrix(tBurn:N,column);

%find the gamma value for each point
for i = 1:length(tBurnMatrix)
    GammaMatrix(i,1) = 2e98*exp(-12017/(tBurnMatrix(i)-273.15));
end

%integrate via trapezium rule and multiply by timestep
damage = 0.01*trapz(GammaMatrix);
end