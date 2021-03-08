function cNext = transientSolver(t)

%initialise mesh variables 
xmin = 0;
xmax = 1;
Ne = 10;

%initialise mesh
msh = OneDimLinearMeshGen(xmin,xmax,Ne);

%get n values - not sure what for in this case
n = length(msh.nvec);

eID = 1;

%define J value
J = msh.elem(eID).J;

%%
%initialise the time integration scheme variables 
%theta = 1 for Forward Euler, 0.5 for crank-nicolson, 0 for backwards Euler
theta = 0;
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

%%
%Initialise Matricies
%define matricies to store values 
globalMatrix = zeros(2*n+1);

globalMass = zeros(2*n+1);
globalStiffness = zeros(2*n+1);

globalVector = zeros(2*n+1,1);
%%
%Define solution vectors
cCurrent = zeros(2*n+1,1);

cNext = zeros(2*n+1,1);

%%
%Set initial conditions

cCurrent(1,1) = 0;
cCurrent(2*n+1,1) = 1;

%%
%7
%loop over time from tstep=1 to N
%total time T=N*dt
for tstep = 1:N
    %loop through all elements of the global matrix
    for i = 1:2:2*n-1
       
       %calculate local element mass matrix
       localMass = massMatrix(J);
   
       %add to correct location in gloabl matrix
       globalMass(i:i+2,i:i+2) = globalMass(i:i+2,i:i+2) + localMass;
   
       %calculate first part of the stiffness matrix
       localStiffness = stiffnessMatrix(J);
       %calculate actual value of stiffness matrix
       localStiffness = D*localStiffness - lmda*localMass;
            
       %add to correct position in gloabl stiffness matrix
       globalStiffness(i:i+2,i:i+2) = globalStiffness(i:i+2,i:i+2) + localStiffness;
       
       x = msh.nvec(i);
       %[k,G,p,c,Pb,Cb,Tb] =  parameterValues(x); 
       [D,lmda] =  laplaceParameterValues(x);
        
       %calculate local element mass matrix
       localMass = massMatrix(i,msh);
              
       %calculate first part of the stiffness matrix
       localStiffness = stiffnessMatrix(i,msh);
       %calculate actual value of stiffness matrix
       localStiffness = D*localStiffness + lmda*localMass;
            
       %add to correct position in gloabl mass & stiffness matricies  
       globalStiffness(i:i+1,i:i+1) = globalStiffness(i:i+1,i:i+1) + localStiffness;
       globalMass(i:i+1,i:i+1) = globalMass(i:i+1,i:i+1) + localMass;
      
    end  

    
    %calculate global matrix
    globalMatrix = globalMass + theta*dt*globalStiffness;
    
    %calculate matrix to multiply previous solution
    
    %calculate vector 
    globalVector = (globalMass - (1-theta)*dt*globalStiffness)*cCurrent;
    
    %loop over elements 
    for i = 1:2:2*n-1
        
        currentF = sourceVector(f,J);
        nextF = currentF;
        %globalSource = globalSource(i:i+2) +localSource;
  
        %calculate element source vectors
        localVector = dt*(theta*nextF+(1-theta)*currentF);

        %add this source matrix to the correct position in the global
        %vector
        globalVector(i:i+2,1) = globalVector(i:i+2,1) + localVector;

        %if NBC
            %localVector = dt*(theta*nextNBC+(1-theta)*currentNBC);
    
       
    end
    
    %%
    %set dirichlet boundary conditions
     globalMatrix(1,:) = 0;
     globalMatrix(1,1) = 1;
     globalMatrix(2*n+1,:) = 0;
     globalMatrix(2*n+1,2*n+1) = 1;
     
     globalVector(1) = 0;
     globalVector(2*n+1) = 1;

    %%
    %solve matrix system to set cnext
    cNext = globalMatrix\globalVector;
    
    %%
    %set ccurrent to cnext
    cCurrent = cNext;
    
    %%
    %reinitialise matricies
    localMatrix = zeros(3);
    globalMatrix = zeros(2*n+1);
    
    globalMass = zeros(2*n+1);
    globalStiffness = zeros(2*n+1);
    
    globalVector = zeros(2*n+1,1);
    
    %plot/write file to cCurrent
    %plot the solution every 5 timesteps
    
%     x = msh.nvec;
%         figure;
%         plot(x,cNext);
%     if(mod(t,5)==0)
%         x = msh.nvec;
%         figure;
%         plot(x,cNext);
%     end
end

end