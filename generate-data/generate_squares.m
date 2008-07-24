function [X,labels] = generate_squaresv2(wholeImgSideDim,internalSqSide)
%wholeImgSideDim=20;
%internalSqSide=5;

ulRowStart=1;
ulRowEnd=wholeImgSideDim-(internalSqSide-1); 
ulColStart=1;
ulColEnd=wholeImgSideDim-(internalSqSide-1);

imgBackground=ones(wholeImgSideDim,wholeImgSideDim);

totInternalSqs=ulRowEnd*ulColEnd;
X=zeros(totInternalSqs,length(imgBackground(:)));
labels=zeros(totInternalSqs,2);

internalSqNum=1;
for ulCol=ulColStart:ulColEnd
    internalSqColCoords=ulCol:ulCol+(internalSqSide-1);
    for ulRow=ulRowStart:ulRowEnd;
        internalSqRowCoords=ulRow:ulRow+(internalSqSide-1);
        
        [internalSqCols,internalSqRows]=meshgrid(internalSqColCoords,internalSqRowCoords);
        imgSq=imgBackground;
        imgSq(internalSqRows(:),internalSqCols(:))=imgBackground(internalSqCols(:),internalSqCols(:))*0;
        %imagesc(imageSq); axis square;
        X(internalSqNum,:)=imgSq(:);
        labels(internalSqNum,:)=[ulRow,ulCol]; 
        %imagesc(reshape(X(internalSqNum,:),[wholeImgSideDim,wholeImgSideDim]));pause(.3)
        internalSqNum=internalSqNum+1;
    end
end


