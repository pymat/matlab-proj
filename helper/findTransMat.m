function [bestFitPts,transMat,sumSqErrVal]=findTransMat(labelsToFit,matchingDRedPoints)


mDRedPts_1=[matchingDRedPoints ones(size(matchingDRedPoints,1),1)];
transMatCoords1=mDRedPts_1\labelsToFit(:,1);
transMatCoords2=mDRedPts_1\labelsToFit(:,2);

transMat=[transMatCoords1 transMatCoords2];

%bestFitPts=[mDRedPts_1*transMatCoords1 mDRedPts_1*transMatCoords2];
bestFitPts=mDRedPts_1*transMat;

% plot(labelsToFit(:,1),labelsToFit(:,2),'b+'); hold on;
% plot(bestFitPts(:,1),bestFitPts(:,2),'rx')

perPtSqErrVec=sum((labelsToFit-bestFitPts).^2,2);
sumSqErrVal=sum(perPtSqErrVec);




















% 
% function testFit()
% 
% 
% title('Best Affine Fits')
% for i=1:length(dimMethods)
%     
%     methodStr=dimMethods{i};
%     outVarStr=['Y' methodStr];
%     outVarStr_1=[outVarStr '_1'];
%     txMethodStr=['tx' methodStr];
%     tyMethodStr=['ty' methodStr];
%     bestFitMethodStr=['bestFit' methodStr];
%     
%     
%     padYStr=[outVarStr_1 '=[' outVarStr ' ones(size(' outVarStr ',1),1)];'];
%     eval(padYStr)
%     
%     calctxStr=[txMethodStr '=' outVarStr_1 '\labels(:,1);'];
%     eval(calctxStr)
%     calcxErrStr=['calcxErr=(labels(:,1)-' outVarStr_1 '*' txMethodStr ');']
%     eval(calcxErrStr)
%     
%     calctyStr=[tyMethodStr '=' outVarStr_1 '\labels(:,2);'];
%     eval(calctyStr)
%     calcyErrStr=['calcyErr=(labels(:,2)-' outVarStr_1 '*' tyMethodStr ');']
%     eval(calcyErrStr)
%     
%     calcTotErr=calcxErr.*calcxErr+calcyErr.*calcyErr
%     calcTotErrSum=sum(calcTotErr)
%     
%     
%     bestFitStr=[bestFitMethodStr '=[' outVarStr_1 '*' txMethodStr ' ' outVarStr_1 '*' tyMethodStr '];'];
%     eval(bestFitStr)
%     
%     plot1Str=['subplot(2,2,i), plot(' bestFitMethodStr '(:,1),' bestFitMethodStr '(:,2),''b+''); hold on'];
%     eval(plot1Str)
%     
%     plot(labels(:,1),labels(:,2),'rx')
%     
%     clear titleStr
%     titleStr{1}=['Best Affine Fit for ' methodStr ];
%     titleStr{2}=['Sum Squared Error for ' methodStr ' = ' num2str(calcTotErrSum)];
%     title(titleStr)
%     %legend('Best affine fit','True')
%     %pause
% end
% saveas(gcf,'bestfits.tiff')
% saveas(gcf,'bestfits.pdf')
% %small write up
% %email pictures of standard result 
% %pictures of best affine fit
% %curve of best affine fit value as parameters vary
% 
% %possibly color by matrix size to determine amount of local distortion
% 
% 
% 
% 
% %(ui,vi)*R=(xi,yi)
% %each (u,v) represents one point that has been mapped down
% %by one of the dimension reduction methods
% 
% %we are interested in the squared error that remains after 
% %each (u,v) is mapped to (xi,yi) via the best affine mapping
% 
% %we solve this by constructing the matrix M:
% % [u1 v1 1;
% %  u2 v2 1;
% %  u3 v3 1;
% %    ...  ;
% %  un vn 1]
% 
% %we are seeking tx = 
% % [a;
% %  c;
% %  e]
% %
% %and ty = 
% % [b;
% %  d;
% %  f]
% %
% 
% %such that M*tx=X
% %and       M*ty=Y
% 
% %where X=[x1,x2,x3,...,xn]'
% %and   Y=[y1,y2,y3,...,yn]'
% 
% %from these valus of tx and ty, we will know the transformation
% % matrix T=
% %   [|   |  0;
% %   tx  ty  0;
% %    |   |  1]
% 
% %write a function that will translate a given matlab line into one suitable
% %for use in a call to eval(),
% %i.e. replace the specific variable names with whatever name string should
% %be used for that call, perhaps via some sort of find and replace code