function [cNext,nodeValues] = transientSolver2(t)

%initialise mesh variables 
xmin = 0;
xmax = 0.01;
Ne = 10;

%initialise mesh
msh = OneDimLinearMeshGen(xmin,xmax,Ne);

%get n values - not sure what for in this case
n = length(msh.nvec);
%eID = 1;
%define J value
%J = msh.elem(eID).J;
k=0;

%%
%initialise the time integration scheme variables 
%theta = 1 for Forward Euler, 0.5 for crank-nicolson, 0 for backwards Euler
theta = 1;
%time step
dt = 0.01;
%number of time steps
N = t/dt;

%%
%define material coefficients
%diffusion coefficient
D = 1;
%lambda
lmda = 1;
%source term
f = 0;

nodeValues = zeros(n,1);
%%
%Initialise Matricies
%define matricies to store values 
globalMatrix = zeros(n);

globalMass = zeros(n);
globalStiffness = zeros(n);

globalVector = zeros(n,1);
%%
%Define solution vectors
cCurrent = zeros(n,1);

cNext = zeros(n,1);

%%
%Set initial conditions

%%
%7
%loop over time from tstep=1 to N
%total time T=N*dt
for tstep = 1:N
    %loop through all elements of the global matrix
    for i = 1:n-1
       
       %calculate local element mass matrix
       localStiffness = stiffnessMatrix(i,msh);
   
       %add to correct location in gloabl matrix
       %globalMass(i:i+1,i:i+1) = globalMass(i:i+1,i:i+1) + localMass;
       
       %calculate first part of the stiffness matrix
       localMass = massMatrix(i,msh);
       %calculate actual value of stiffness matrix
       localMass = D*localMass; %- lmda*localStiffness;
            
       %add to correct position in gloabl stiffness matrix
       %globalStiffness(i:i+1,i:i+1) = globalStiffness(i:i+1,i:i+1) + localStiffness;
       
       globalMass(i:i+1,i:i+1) = globalMass(i:i+1,i:i+1) + localMass;
       globalStiffness(i:i+1,i:i+1) = globalStiffness(i:i+1,i:i+1) + localStiffness;
      
    end  

    
    %calculate global matrix
    globalMatrix = globalMass + (theta*dt*globalStiffness);
        
    %calculate vector 
    globalVector = (globalMass - (1-theta)*dt*globalStiffness)*cCurrent;
    
%     globalMatrix = globalMass + theta*dt*globalStiffness;
%         
%     %calculate vector 
%     globalVector = (globalMass - (1-theta)*dt*globalStiffness)*cCurrent;
    
    %loop over elements
    
    for i = 1:n-1
        
        currentF = sourceVector(k,i,msh);
        nextF = currentF;
        %globalSource = globalSource(i:i+2) +localSource;
  
        %calculate element source vectors
        localVector = dt*(theta*nextF+(1-theta)*currentF);

        %add this source matrix to the correct position in the global
        %vector
        globalVector(i:i+1,1) = globalVector(i:i+1,1) + localVector;

        %if NBC
            %localVector = dt*(theta*nextNBC+(1-theta)*currentNBC);
    
       
    end
    
    %%
    %set dirichlet boundary conditions
     globalMatrix(1,:) = 0;
     globalMatrix(1,1) = 1;
     globalMatrix(n,:) = 0;
     globalMatrix(n,n) = 1;
     
     globalVector(1) = 0;
     globalVector(n) = 1;

    %%
    %solve matrix system to set cnext
    cNext = globalMatrix\globalVector;
    
    %%
    %set ccurrent to cnext
    cCurrent = cNext;
    
    %%
    %reinitialise matricies
    localMatrix = zeros(2);
    globalMatrix = zeros(n);
    
    globalMass = zeros(n);
    globalStiffness = zeros(n);
    
    globalVector = zeros(n,1);
     
    if(mod(tstep,1)==0)
        x = msh.nvec;
        hold on
        plot(x,cNext);
        hold off
        nodeValues(tstep+1) = cNext(9);
    end
end

% x = msh.nvec;
%         figure;
%         plot(x,cNext);
end