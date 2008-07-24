function fitSqVals = makeFitSquaresv3(bigSqSide,smSqSide)

if not(mod(smSqSide,2))
    disp('smSqSide must be an odd number')
    return;
end

bigSq=zeros(bigSqSide);
%imagesc(bigSq);

ulColStart=1;
ulColEnd=bigSqSide-(smSqSide-1);

ulRowStart=1;
ulRowEnd=bigSqSide-(smSqSide-1);

%list of the row and column values of the 
%upper left corner of the small sqare
ulColList=(ulColStart:ulColEnd);
ulRowList=(ulRowStart:ulRowEnd);

%the selection squares are numbered as they are generated
%the squares move down from top to bottom, and only then shift to the right
fitSqNum=1;
for j=ulColStart:ulColEnd
    for i=ulRowStart:ulRowEnd
        ulRow=ulRowList(i);
        ulCol=ulColList(j);
        
        smSqColCoords=(ulCol:ulCol+(smSqSide-1));
        smSqRowCoords=(ulRow:ulRow+(smSqSide-1))';

        smSqCtrCoords=[smSqRowCoords(ceil(smSqSide/2)) smSqColCoords(ceil(smSqSide/2))];
        smSqCtrInd=sub2ind(size(bigSq),smSqCtrCoords(1),smSqCtrCoords(2));
        
        [smSqGridCols,smSqGridRows]=meshgrid(smSqColCoords,smSqRowCoords);

        smSqGridInds=sub2ind(size(bigSq),smSqGridRows(:),smSqGridCols(:));
        
        fitSqVals(fitSqNum).fitSqGridRows=smSqGridRows;
        fitSqVals(fitSqNum).fitSqGridCols=smSqGridCols;
        fitSqVals(fitSqNum).fitSqCtrRow=smSqCtrCoords(1);
        fitSqVals(fitSqNum).fitSqCtrCol=smSqCtrCoords(2);
        fitSqVals(fitSqNum).fitSqULRow=ulRow;
        fitSqVals(fitSqNum).fitSqULCol=ulCol;
        fitSqVals(fitSqNum).fitSqGridInds=smSqGridInds;
        fitSqVals(fitSqNum).fitSqCtrInd=smSqCtrInd;
        
%         tempSq=bigSq;
%         tempSq(smSqGridRows(:),smSqGridCols(:))=1;
%         imagesc(tempSq)
%         titleStr{1}=['ulCol = ' num2str(ulCol) ', ulRow = ' num2str(ulRow)];
%         titleStr{2}=['ctrCol = ' num2str(smSqCtrCoords(2)) ', ctrRow = ' num2str(smSqCtrCoords(1))];
%         title(titleStr)
        
        fitSqNum=fitSqNum+1;
%        pause
    end
end
 