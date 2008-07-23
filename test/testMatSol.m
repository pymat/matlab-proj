x=[0 0; 0 1; 1 0; 1 1];
x1= [x ones(size(x,1),1)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Random matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R=rand(3);
y=x1*R;


divBy=repmat(y(:,3),1,3);
y1=y./divBy;
plot(x1(:,1),x1(:,2),'r+'); hold on;
plot(y1(:,1),y1(:,2),'bx'); hold on;
%axis([-2 2 -2 2]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Translation matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
identM=eye(3);
xTrans=rand(1);yTrans=rand(1);
transM=identM;
transM(3,1:2)=[xTrans,yTrans];


R=transM;
y=x1*R;


divBy=repmat(y(:,3),1,3);
y1=y./divBy;
plot(x1(:,1),x1(:,2),'r+'); hold on;
plot(y1(:,1),y1(:,2),'bx'); hold on;
%axis([-2 2 -2 2]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scale matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
identM=eye(3);
xScale=rand(1);yScale=rand(1);
scaleM=identM;
scaleM(1,1)=xScale;
scaleM(2,2)=yScale;


R=scaleM;
y=x1*R;


divBy=repmat(y(:,3),1,3);
y1=y./divBy;
plot(x1(:,1),x1(:,2),'r+'); hold on;
plot(y1(:,1),y1(:,2),'bx'); hold on;
%axis([-2 2 -2 2]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rotation matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta=2*pi*rand(1);
rotM =[cos(theta)  sin(theta) 0;
      -sin(theta)  cos(theta) 0;
       0           0          1];


R=rotM;
y=x1*R;


divBy=repmat(y(:,3),1,3);
y1=y./divBy;
plot(x1(:,1),x1(:,2),'r+'); hold on;
plot(y1(:,1),y1(:,2),'bx'); hold on;
%axis([-2 2 -2 2]);
axis equal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   









