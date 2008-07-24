bigSqSide=5;
smSqSide=3;
bigSqNumEntries=bigSqSide^2;
bigSqX=reshape(1:bigSqNumEntries,[bigSqSide bigSqSide]);
bigSqY=-1*bigSqX;

bigSqXVec=bigSqX(:);
bigSqYVec=bigSqY(:);

bigSqX=reshape(bigSqXVec,[bigSqSide,bigSqSide]);
bigSqY=reshape(bigSqYVec,[bigSqSide,bigSqSide]);



sqPoints = makeFitSquaresv3(bigSqSide,smSqSide)

bigSqX(sqPoints(1).smSqGridInds)

bigSqY(sqPoints(1).smSqGridInds)
