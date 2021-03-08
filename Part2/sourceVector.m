function localVector = sourceVector(eID,msh)

%get appropriate J value from mesh data structure
J = msh.elem(eID).J;

n = length(msh.nvec);

%create 2x2 matrix to store diffusion values
localVector = zeros(2,1);

%fill in each term in the empty matrix
%spatially varying source term matrix
localVector(1,1) = (J);
localVector(2,1) = (J);

end
