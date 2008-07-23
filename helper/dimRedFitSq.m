%dimMethods={'PCA','Isomap','MVU','LLE','Laplacian'};
dimMethods={'PCA','Isomap','LLE','Laplacian'};

wholeImgSideDim=20;
internalSqSide=5;
fitSqSide=5;
sideOfLabelSq=wholeImgSideDim-(internalSqSide-1);

numLabelRows=wholeImgSideDim-(internalSqSide-1);
numLabelCols=wholeImgSideDim-(internalSqSide-1);

%create square images
[X, labels] = generate_squaresv2(wholeImgSideDim,internalSqSide);



labelsRows=labels(:,1);
labelsRowsSq=reshape(labelsRows,[numLabelRows numLabelCols]); %corresponds to sqPoints(1).smSqGrdRows
labelsCols=labels(:,2);
labelsColsSq=reshape(labelsCols,[numLabelRows numLabelCols]); %corresponds to sqPoints(1).smSqGrdCols


%pick number of dimensions of method output
%d = round(intrinsic_dim(X,'MLE'));
d=2;


for i=1:length(dimMethods)
    methodStr=dimMethods{i};
    outVarStr=['Y' methodStr];
    commandStr=[outVarStr,' = compute_mapping(X,''',methodStr,''',d);'];
    eval(commandStr)  
end


%plot initial dimred results, immediately after fitting
figure
for i=1:length(dimMethods)
    methodStr=dimMethods{i};
    outVarStr=['Y' methodStr];
    %drawStr=['figure, scatter( ',outVarStr,'(:,1), ',outVarStr,'(:,2), 5, labels), drawnow'];
    drawStr=['subplot(2,2,i), scatter( ',outVarStr,'(:,1), ',outVarStr,'(:,2), 5, labels(:,1)), drawnow'];
    %drawStr=['figure, scatter( ',outVarStr,'(:,1), ',outVarStr,'(:,2), 5), drawnow'];
    eval(drawStr)
    titleStr=['title(''',methodStr,''')'];
    eval(titleStr)
    %pause
end
saveas(gcf,'initial.tiff')
saveas(gcf,'initial.pdf')



%find best affine fit of dimred points to true points
%plot resulting fits
figure
title('Best Affine Fits - Whole Set')
for i=1:length(dimMethods)
    
    methodStr=dimMethods{i};
    outVarStr=['Y' methodStr];
    outVarStr_1=[outVarStr '_1'];
    txMethodStr=['tx' methodStr];
    tyMethodStr=['ty' methodStr];
    bestFitMethodStr=['bestFit' methodStr];
    
    
    padYStr=[outVarStr_1 '=[' outVarStr ' ones(size(' outVarStr ',1),1)];'];
    eval(padYStr)
    
    calctxStr=[txMethodStr '=' outVarStr_1 '\labels(:,1);'];
    eval(calctxStr)
    calcxErrStr=['calcxErr=(labels(:,1)-' outVarStr_1 '*' txMethodStr ');'];
    eval(calcxErrStr);
    
    calctyStr=[tyMethodStr '=' outVarStr_1 '\labels(:,2);'];
    eval(calctyStr);
    calcyErrStr=['calcyErr=(labels(:,2)-' outVarStr_1 '*' tyMethodStr ');'];
    eval(calcyErrStr);
    
    calcTotErr=calcxErr.*calcxErr+calcyErr.*calcyErr;
    calcTotErrSum=sum(calcTotErr);
    
    
    bestFitStr=[bestFitMethodStr '=[' outVarStr_1 '*' txMethodStr ' ' outVarStr_1 '*' tyMethodStr '];'];
    eval(bestFitStr)
    
    plot1Str=['subplot(2,2,i), plot(' bestFitMethodStr '(:,1),' bestFitMethodStr '(:,2),''b+''); hold on'];
    eval(plot1Str)
    
    plot(labels(:,1),labels(:,2),'rx')
    
    clear titleStr
    titleStr{1}=['Best Affine Fit for ' methodStr ];
    titleStr{2}=['Sum Squared Error for ' methodStr ' = ' num2str(calcTotErrSum)];
    title(titleStr)
    %legend('Best affine fit','True')
    %pause
end
saveas(gcf,'bestfits_whole.tiff')
saveas(gcf,'bestfits_whole.pdf')





%fitSqSide=5;
fitSqVals = makeFitSquaresv3(sideOfLabelSq,fitSqSide);
fitSqStartNum=1;
fitSqEndNum=length(fitSqVals);

figure;colormap(summer);hold on;
for i=1:length(dimMethods)
    methodStr=dimMethods{i};
    outVarStr=['Y' methodStr];
    for j=1:length(dimMethods{i}.)
    commandStr=['[transCoords,errColors]=calculateFits(fitSqVals,labels,' outVarStr ');'];
    eval(commandStr)  
    
    totSumSqErr=sum(errColors);
    end
    
    subplot(2,2,i),scatter(transCoords(:,1),transCoords(:,2),25,errColors,'filled');hold on;
    plot(labels(:,1),labels(:,2),'ks')
    titleStr{1}=['Sub-fit results for ' methodStr];
    titleStr{2}=['Sub-fit SSE = ' num2str(totSumSqErr)];
    title(titleStr);
    colorbar;
end
saveas(gcf,'bestfits_sub.tiff')
saveas(gcf,'bestfits_sub.pdf')







































%small write up
%email pictures of standard result 
%pictures of best affine fit
%curve of best affine fit value as parameters vary

%possibly color by matrix size to determine amount of local distortion




%(ui,vi)*R=(xi,yi)
%each (u,v) represents one point that has been mapped down
%by one of the dimension reduction methods

%we are interested in the squared error that remains after 
%each (u,v) is mapped to (xi,yi) via the best affine mapping

%we solve this by constructing the matrix M:
% [u1 v1 1;
%  u2 v2 1;
%  u3 v3 1;
%    ...  ;
%  un vn 1]

%we are seeking tx = 
% [a;
%  c;
%  e]
%
%and ty = 
% [b;
%  d;
%  f]
%

%such that M*tx=X
%and       M*ty=Y

%where X=[x1,x2,x3,...,xn]'
%and   Y=[y1,y2,y3,...,yn]'

%from these valus of tx and ty, we will know the transformation
% matrix T=
%   [|   |  0;
%   tx  ty  0;
%    |   |  1]

%write a function that will translate a given matlab line into one suitable
%for use in a call to eval(),
%i.e. replace the specific variable names with whatever name string should
%be used for that call, perhaps via some sort of find and replace code