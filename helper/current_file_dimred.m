clear all
methods(1).name='PCA';

methods(2).name='Isomap';
methods(2).params(1).name='numNeighbors';
methods(2).params(1).value=12;

methods(3).name='LLE';
methods(3).params(1).name='numNeighbors';
methods(3).params(1).value=12;

methods(4).name='Laplacian';
methods(4).params(1).name='numNeighbors';
methods(4).params(1).value=12;
methods(4).params(2).name='sigma';
methods(4).params(2).value=1;




