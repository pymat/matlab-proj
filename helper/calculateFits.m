function [transCoords,errColors]=calculateFits(fitSqVals,labels,YMethod)

labelsRows=labels(:,1);
labelsCols=labels(:,2);
numLabelRows=sqrt(length(labelsRows));
numLabelCols=sqrt(length(labelsCols));

fitSqStartNum=1;
fitSqEndNum=length(fitSqVals);

transCoords=zeros(size(labels));

errColors=zeros(size(labels),1);



for fitSqNum=fitSqStartNum:fitSqEndNum
    
    fitSqRows=labelsRows(fitSqVals(fitSqNum).fitSqGridInds);
    fitSqCols=labelsCols(fitSqVals(fitSqNum).fitSqGridInds);
       fitSqSide=sqrt(length(fitSqRows));
       fitSqCtr=ceil(fitSqSide/2);
       fitSqCtrInd=sub2ind([fitSqSide fitSqSide],fitSqCtr,fitSqCtr);
    fitSqInds=sub2ind([numLabelRows,numLabelCols],fitSqRows,fitSqCols);

    labelsToFit=labels(fitSqInds,:);
    matchingDRedPoints=YMethod(fitSqInds,:);
    
    [bestFitPts,transMat,sumSqErrVal]=findTransMat(labelsToFit,matchingDRedPoints);
    
    transCoords(fitSqVals(fitSqNum).fitSqCtrInd,:)=bestFitPts(fitSqCtrInd,:);
    
    errColors(fitSqVals(fitSqNum).fitSqCtrInd)=sumSqErrVal;

end