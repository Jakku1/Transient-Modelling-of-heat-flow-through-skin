function cNext  = transientSolverFull(t)
%[cNext, solutionMatrix]
%initialise mesh variables 
xmin = 0;
xmax = 0.01;
Ne = 60;

%initialise mesh
msh = OneDimLinearMeshGen(xmin,xmax,Ne);

%get n values - not sure what for in this case
n = length(msh.nvec);


%%
%initialise the time integration scheme variables 
%theta = 1 for Forward Euler, 0.5 for crank-nicolson, 0 for backwards Euler
theta = 1;
%time step
dt = 0.01;
%number of time steps
N = t/dt;

%%
%Initialise Matricies
%define matricies to store values 
globalMatrix = zeros(n);

globalMass = zeros(n);
globalStiffness = zeros(n);

solutionMatrix = ones(N,2);
solutionMatrix(1,:) = solutionMatrix(1,:)*310.15;

globalSource = zeros(n,1);
%%
%Define solution vectors
cCurrent = ones(n,1);
cCurrent = 310.15*cCurrent;

cNext = zeros(n,1);

%%
%7
%loop over time from tstep=1 to N
%total time T=N*dt
for tstep = 1:N
    %loop through all elements of the global matrix
    for i = 1:n-1
       
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
    globalMatrix = globalMass + (theta*dt*globalStiffness);
        
    %calculate vector 
    globalVector = (globalMass - (1-theta)*dt*globalStiffness)*cCurrent;
        
    %loop over elements
    
    for i = 1:n-1
        
        x = msh.nvec(i);
        %Define parameter values
        [D,lmda] =  laplaceParameterValues(x);
        
        %define current source vector
        localSource = sourceVector(i,msh);
        localSource = 310.15*lmda*localSource;
        
        %calculate local vector using local source vector
        localVector = dt*(theta*localSource+(1-theta)*localSource);

        %add this source matrix to the correct position in the global
        %vector
        globalVector(i:i+1,1) = globalVector(i:i+1,1) + localVector;    
       
    end
    
    %%
    %set dirichlet boundary conditions
     globalMatrix(1,:) = 0;
     globalMatrix(1,1) = 1;
     globalMatrix(n,:) = 0;
     globalMatrix(n,n) = 1;
     
     %T at x=0 for all temperatures = 393.15
     globalVector(1) = 328.87;
     %T at x=B for all temperatures = 310.15
     globalVector(n) = 310.15;

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
    %%
    %plot solutions every 100 timesteps and on the first timestep
    if(mod(tstep,1)==0 || tstep == 1)
        x = msh.nvec;
        hold on
        plot(x,cNext);
        hold off
    end
    
    %save the nodal values at every timestep for the boundary nodes
%     solutionMatrix(tstep+1,1) = cCurrent(11);
%     solutionMatrix(tstep+1,2) = cCurrent(31);
end

end