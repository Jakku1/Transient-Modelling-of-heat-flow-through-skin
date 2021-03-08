function elemat = massMatrix(J)

%calculate dXidx value, the inverse of J
dXidx = 1/J;

%calculate dpsi0dzy
%where n =[0,1]
dXi = [-1/2 1/2];

%get the final value in nvec
Xi = msh.nvec(length(msh.nvec));

%create 2x2 matrix to store diffusion values
elemat = zeros(2,2);

%loop through rows and columns filling in value for each element in the
%diffusion matrix
for i = 1:2
    for j = 1:2
        elemat(i,j) = dXi(i)*dXidx*J*dXi(j)*dXidx*D*(Xi-(-Xi)); 
    end
end

end


%convert x co-ordinates to zy co-ordinates?