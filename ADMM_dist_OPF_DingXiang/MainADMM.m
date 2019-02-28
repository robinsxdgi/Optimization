% This part will realize the x,y,u iteration.
% initialization
%%
% 1.initilize y0
n=10;
ri=[0,0.16,0.824,0.144,1.026,0.741,0.528,0.358,2.032,0.502];
xi=[0,0.388,0.315,0.349,0.421,0.466,0.468,0.314,0.798,0.441];
rji=[0,0,0,0,0,0,0,0,0,0;
     0.16,0,0,0,0,0,0,0,0,0;
     0,0.824,0,0,0,0,0,0,0,0;
     0,0.144,0,0,0,0,0,0,0,0;
     0,0,0,1.026,0,0,0,0,0,0;
     0,0,0,0.741,0,0,0,0,0,0;
     0,0,0,0.528,0,0,0,0,0,0;
     0,0,0,0,0,0,0.358,0,0,0;
     0,0,0,0,0,0,0,2.032,0,0;
     0,0,0,0,0,0,0,0.502,0,0;];
xji=[0,0,0,0,0,0,0,0,0,0;
     0.388,0,0,0,0,0,0,0,0,0;
     0,0.315,0,0,0,0,0,0,0,0;
     0,0.349,0,0,0,0,0,0,0,0;
     0,0,0,0.421,0,0,0,0,0,0;
     0,0,0,0.466,0,0,0,0,0,0;
     0,0,0,0.468,0,0,0,0,0,0;
     0,0,0,0,0,0,0.314,0,0,0;
     0,0,0,0,0,0,0,0.798,0,0;
     0,0,0,0,0,0,0,0.441,0,0;];
 

%y1,y2 : PPii, QQii
%y3 : lii
%y4 : vii
%y5,y6 : pii, qii
%y7 :viAi
%y8~y16 : PPij%%%%%%%%%%%%%%%%%
%y17~y25 : QQij
%y26~y34 : lij%%%%%%%%%%%%%%%%%
y=[0,-7,-1,-6,-1,-1,-4,-3,-1,-1;%PPii
   0,-7,-1,-6,-1,-1,-4,-3,-1,-1;%QQii
   0,98,2,72,2,2,32,18,2,2;%lii
   0,1,1,1,1,1,1,1,1,1;%vii %since the first node's voltage will not be used in constraints,so we make it 10 to be same as x(4,1)
   7,0,-1,0,-1,-1,-1,-1,-1,-1;%pii
   7,0,-1,0,-1,-1,-1,-1,-1,-1;%qii
   0,1,1,1,1,1,1,1,1,1;%viAi %note that the first point doesn't effect
   0,0,0,0,0,0,0,0,0,0;%PP1i 
   0,-7,0,0,0,0,0,0,0,0;%PP2i 
   0,-7,0,0,0,0,0,0,0,0;%PP3i 
   0,0,0,-6,0,0,0,0,0,0;%PP4i 
   0,0,0,-6,0,0,0,0,0,0;%PP5i 
   0,0,0,-6,0,0,0,0,0,0;%PP6i 
   0,0,0,0,0,0,-4,0,0,0;%PP7i 
   0,0,0,0,0,0,0,-3,0,0;%PP8i 
   0,0,0,0,0,0,0,-3,0,0;%PP9i
   0,0,0,0,0,0,0,0,0,0;%QQ1i 
   0,-7,0,0,0,0,0,0,0,0;%QQ2i 
   0,-7,0,0,0,0,0,0,0,0;%QQ3i 
   0,0,0,-6,0,0,0,0,0,0;%QQ4i 
   0,0,0,-6,0,0,0,0,0,0;%QQ5i 
   0,0,0,-6,0,0,0,0,0,0;%QQ6i 
   0,0,0,0,0,0,-4,0,0,0;%QQ7i 
   0,0,0,0,0,0,0,-3,0,0;%QQ8i 
   0,0,0,0,0,0,0,-3,0,0;%QQ9i
   0,0,0,0,0,0,0,0,0,0;%l1i 
   0,98,0,0,0,0,0,0,0,0;%l2i 
   0,98,0,0,0,0,0,0,0,0;%l3i 
   0,0,0,72,0,0,0,0,0,0;%l4i 
   0,0,0,72,0,0,0,0,0,0;%l5i 
   0,0,0,72,0,0,0,0,0,0;%l6i 
   0,0,0,0,0,0,32,0,0,0;%l7i 
   0,0,0,0,0,0,0,18,0,0;%l8i 
   0,0,0,0,0,0,0,18,0,0;%l9i
   ];
x=[0,-7.1,-1.1,-6,-1,-1,-4,-3,-1,-1;%PPii
   0,-7,-1,-6,-1,-1,-4,-3,-1,-1;%QQii
   0,98,2,72,2,2,32,18,2,2;
   0,1,1,1,1,1,1,1,1,1;
   7,0,-1,0,-1,-1,-1,-1,-1,-1;
   7,0,-1,0,-1,-1,-1,-1,-1,-1;
   ];

% uii=[0,1,1,1,1,1,1,1,1,1;
%      1,1,1,1,1,1,1,1,1,1;
%      1,1,1,1,1,1,1,1,1,1;
%      1,1,1,1,1,1,1,1,1,1;];
% uiAi=[1,1,1,1,1,1,1,1,1,1];
% uij1=[1,0,0,0,0,0,0,0,0,0;%u011,u111,u211,u311...
%       0,1,0,0,0,0,0,0,0,0;%u021
%       0,1,0,0,0,0,0,0,0,0;
%       0,0,1,1,0,0,0,0,0,0;
%       0,0,0,1,0,0,0,0,0,0;
%       0,0,0,1,0,0,0,0,0,0;
%       0,0,0,0,0,0,1,0,0,0;
%       0,0,0,0,0,0,0,1,0,0;
%       0,0,0,0,0,0,0,1,0,0;
%       ];
% uij2=[1,0,0,0,0,0,0,0,0,0;%u012,u112,u212,u312...
%       0,1,0,0,0,0,0,0,0,0;%u022
%       0,1,0,0,0,0,0,0,0,0;
%       0,0,1,1,0,0,0,0,0,0;
%       0,0,0,1,0,0,0,0,0,0;
%       0,0,0,1,0,0,0,0,0,0;
%       0,0,0,0,0,0,1,0,0,0;
%       0,0,0,0,0,0,0,1,0,0;
%       0,0,0,0,0,0,0,1,0,0;];
uii=zeros(4,10);
uiAi=zeros(1,10);
uij1=zeros(9,10);
uij2=zeros(9,10);

ro=1/100;
Nci=[1,2,0,3,0,0,1,2,0,0];      
xk1=[];
yk1=[];
Luxi=[];%Dosen't count just for a moment

%%
% Prepare for the start of the iteration
xPij=zeros(9,10);% prepare xpij
% xPij(1,1)=x(1,1);
xPij(2,2)=x(1,2);
xPij(3,2)=x(1,2);
xPij(4,4)=x(1,4);
xPij(5,4)=x(1,4);
xPij(6,4)=x(1,4);
xPij(7,7)=x(1,7);
xPij(8,8)=x(1,8);
xPij(9,8)=x(1,8);

xlij=zeros(9,10);% prepare xlij
% xlij(1,1)=x(3,1);
xlij(2,2)=x(3,2);
xlij(3,2)=x(3,2);
xlij(4,4)=x(3,4);
xlij(5,4)=x(3,4);
xlij(6,4)=x(3,4);
xlij(7,7)=x(3,7);
xlij(8,8)=x(3,8);
xlij(9,8)=x(3,8);

x(1,:)=[0,x(1,2:end)];
x(3,:)=[0,x(3,2:end)];

xk1_u=[x(1,:);x(3,:);x(4,:);x(5,:);x(4,:);xPij;xlij];

%x1,x3,x4,x5 corresponds to P,l,v,p respectively.


yk1_u=y([1,3,4,5,7,8:16,26:34],:);
rk(1)=norm(xk1_u(:)-yk1_u(:))^2%residual for primal and dual;
% sk=ro*norm(yk1_u(:))
rn=1;
m=10000
while rn <500
    % x iteration
    ro=1/(m);
    % update for x on node 1, the root node.
    options = optimset('Algorithm', 'active-set');
    f = @(xx)Agentxobj(xx,y(1,1),y(2,1),y(3,1),y(4,1),y(5,1),y(6,1),y(7,1),y(8:16,1),y(17:25,1),y(26:34,1),uii(:,1),uiAi(1),uij1(:,1),uij2(:,1),ro,Nci(1));
    g = @(xx)Agentx0con(xx,0,1e12,0,1e12,0,1e12);
    [xk1(:,1),Luxi] = fmincon(f,x(:,1),...
         [],[],[],[],[],[],g,options);
    % update for x on other nodes
    for i=2:n
        %In the line below, note to be restrict, we need y(7,2), but it's fine
        %to use y(7,1) which means we add one more node before the root node,
        %it always the same as the root node is fine. But it increases some
        %computation load.
        f = @(xx)Agentxobj(xx,y(1,i),y(2,i),y(3,i),y(4,i),y(5,i),y(6,i),y(7,i),y(8:16,i),y(17:25,i),y(26:34,i),uii(:,i),uiAi(i),uij1(:,i),uij2(:,i),ro,Nci(i));
        if i==2 | i==4
            g = @(xx)Agentxcon(xx,0.995,1.005,0,0,0,0);
        else
            g = @(xx)Agentxcon(xx,0.995,1.005,-1,-1,-1,-1);
        end
        [xk1(:,i),Luxi] = fmincon(f,x(:,i),...
         [],[],[],[],[],[],g,options);
    end
    x=xk1;
    %PPii,QQii,lii,vii,pii,qii,viAi,PPij,QQij,lij,uii,uiAi,uij1,uij2,ro,Nci
    %y1,y2 : PPii, QQii
    %y3 : lii
    %y4 : vii
    %y5,y6 : pii, qii
    %y7 :viAi
    %y8~y16 : PPij%%%%%%%%%%%%%%%%%
    %y17~y25 : QQij
    %y26~y34 : lij%%%%%%%%%%%%%%%%%
    %uii is a vector 4*1
    %uij1, uij2 are vectors in this case 9*1

    %%
    %y iteration
    %update for y on node 1, the root node.
    f = @(yy)Agentyobj(yy,xk1(1,1),xk1(2,1),xk1(3,1),xk1(4,1),xk1(5,1),xk1(6,1),uii(:,1),uiAi(1),uij1(:,1),uij2(:,1),ro,Nci(1));
    g = @(yy)Agenty0con(yy,ri(1),xi(1),rji(2:end,1),xji(2:end,1));
    [yk1(:,1),Luyi] = fmincon(f,y(:,1),...
         [],[],[],[],[],[],g,options);
    % update for y on other nodes.
    for i=2:n
        f = @(yy)Agentyobj(yy,xk1(1,i),xk1(2,i),xk1(3,i),xk1(4,i),xk1(5,i),xk1(6,i),uii(:,i),uiAi(i),uij1(:,i),uij2(:,i),ro,Nci(i));
        g = @(yy)Agentycon(yy,ri(i),xi(i),rji(2:end,i),xji(2:end,i),i);
        [yk1(:,i),Luyi] = fmincon(f,y(:,i),...
         [],[],[],[],[],[],g,options);
    end
    y=yk1;
%     y(8:34,:)=zeros(27,10);
% %     y(8,1)=yk1(8,1);
%     y(9,2)=yk1(9,2);
%     y(10,2)=yk1(10,2);
%     y(11,4)=yk1(11,4);
%     y(12,4)=yk1(12,4);
%     y(13,4)=yk1(13,4);
%     y(14,7)=yk1(14,7);
%     y(15,8)=yk1(15,8);
%     y(16,8)=yk1(16,8);
%     
% %     y(17,1)=yk1(17,1);
%     y(18,2)=yk1(18,2);
%     y(19,2)=yk1(19,2);
%     y(20,4)=yk1(20,4);
%     y(21,4)=yk1(21,4);
%     y(22,4)=yk1(22,4);
%     y(23,7)=yk1(23,7);
%     y(24,8)=yk1(24,8);
%     y(25,8)=yk1(25,8);
%     
% %     y(26,1)=yk1(26,1);
%     y(27,2)=yk1(27,2);
%     y(28,2)=yk1(28,2);
%     y(29,4)=yk1(29,4);
%     y(30,4)=yk1(30,4);
%     y(31,4)=yk1(31,4);
%     y(32,7)=yk1(32,7);
%     y(33,8)=yk1(33,8);
%     y(34,8)=yk1(34,8);
    
    %%
    %u iteration
    uk=[uii;uiAi;uij1;uij2];
    xPij=zeros(1,10);% prepare xpij
%     xPij(1,1)=x(1,1);
    xPij(2,2)=x(1,2);
    xPij(3,2)=x(1,2);
    xPij(4,4)=x(1,4);
    xPij(5,4)=x(1,4);
    xPij(6,4)=x(1,4);
    xPij(7,7)=x(1,7);
    xPij(8,8)=x(1,8);
    xPij(9,8)=x(1,8);
    
    xlij=zeros(9,10);% prepare xlij
%     xlij(1,1)=x(3,1);
    xlij(2,2)=x(3,2);
    xlij(3,2)=x(3,2);
    xlij(4,4)=x(3,4);
    xlij(5,4)=x(3,4);
    xlij(6,4)=x(3,4);
    xlij(7,7)=x(3,7);
    xlij(8,8)=x(3,8);
    xlij(9,8)=x(3,8);
    
    x(1,:)=[0,x(1,2:end)];
    x(3,:)=[0,x(3,2:end)];
    
    xk1_u=[x(1,:);x(3,:);x(4,:);x(5,:);x(4,:);xPij;xlij];%make xk1 into the form that is suitable for u iteration.
    yk1_u=y([1,3,4,5,7,8:16,26:34],:);%9101112131415161718
    uk1=uk+ro.*(xk1_u-yk1_u);
    uii=uk1(1:4,:);%update uii
    uiAi=uk1(5,:);
    uij1=uk1(6:14,:);
    uij2=uk1(15:23,:);
    rn=rn+1;
    rk(rn)=norm(xk1_u(:)-yk1_u(:))^2%residual update;
    m=m+1
end


%x1,x3,x4,x5 corresponds to P,l,v,p respectively.
%y1 : PPii
%y3 : lii
%y4 : vii
%y5 : pii
%y7 : viAi
%y8~y16 : PPij%%%%%%%%%%%%%%%%%
%y26~y34 : lij%%%%%%%%%%%%%%%%%




%convergence creterion
