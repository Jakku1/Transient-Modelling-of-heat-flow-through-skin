function reacelemat = LaplaceReacElementMatrix(lmda,eID,msh)

%assign J value from data structure
J = msh.elem(eID).J;

%get value of Xi
Xi = msh.nvec(length(msh.nvec));

%create empty matrix to store output values
reacelemat = zeros(2,2);

%calculate each matrix value and put into the matrix
reacelemat(1,1) = lmda*-2/3*J*(((1-Xi)/2)^3-((1+Xi)/2)^3);
reacelemat(1,2) = lmda*J*(((3*Xi-Xi^3)/12)-((3*-Xi-(-Xi)^3)/12));
reacelemat(2,1) = reacelemat(1,2);
reacelemat(2,2) = lmda*-2/3*J*(((1-Xi)/2)^3-((1+Xi)/2)^3);

end