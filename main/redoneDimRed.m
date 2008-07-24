%make method list
dimMethods={'PCA','Isomap','LLE','Laplacian'};
%pick method
dimMethod=dimMethods{1};

wholeImgSideDim=20;
internalSqSide=5;
sideOfLabelSq=wholeImgSideDim-(internalSqSide-1);

numLabelRows=wholeImgSideDim-(internalSqSide-1);
numLabelCols=wholeImgSideDim-(internalSqSide-1);

%create square images
[X, labels] = generate_squaresv2(wholeImgSideDim,internalSqSide);


labelsRows=labels(:,1);
labelsRowsSq=reshape(labelsRows,[numLabelRows numLabelCols]); %corresponds to sqPoints(1).smSqGrdRows
labelsCols=labels(:,2);
labelsColsSq=reshape(labelsCols,[numLabelRows numLabelCols]); %corresponds to sqPoints(1).smSqGrdCols

fitSqSide=5;
fitSqVals = makeFitSquaresv3(sideOfLabelSq,fitSqSide);


fitSqVals(1).fitSqGridInds

%pick number of dimensions of method output
%d = round(intrinsic_dim(X,'MLE'));
d=2;


%apply method
methodStr=dimMethod;
outVarStr=['Y' methodStr];
computeMapStr=[outVarStr,' = compute_mapping(X,''',methodStr,''',d);'];
eval(computeMapStr)

%should save methodResults

%show the methodResults
%drawStr=['figure, scatter( ',outVarStr,'(:,1), ',outVarStr,'(:,2), 5),drawnow'];
%drawStr=['subplot(2,2,i), scatter( ',outVarStr,'(:,1), ',outVarStr,'(:,2), 5, labels(:,1)), drawnow'];
drawStr=['figure, scatter( ',outVarStr,'(:,1), ',outVarStr,'(:,2), 5, labels(:,1)), drawnow'];
eval(drawStr)
titleStr=['title(''',methodStr,' initial results',''')'];
eval(titleStr)
%pause

%should save initial plot results


%should pass methodResults and targetValues into a fit function, along with
%the specified fit size
%the result should be the residual squared error for each area that has
%been fit
