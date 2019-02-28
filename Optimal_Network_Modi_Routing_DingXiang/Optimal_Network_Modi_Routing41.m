%Test the Bonus Qeustion with connection to Heuristic Phase I.
%Data file.

clear all;

% 0. ESLx: Existed Station Locations (x axis); 
%    ESLy: Existed Station Locations (y axis);
ESLx_case1 = [0,50,250,400,0  ,250,150,300,50 ,350,150,100,400,250];
ESLy_case1 = [0,50,50 ,50 ,100,100,150,150,200,200,250,300,300,350];


% 1. EB: After Phase I, Existed Building Form
EB_case1 = [6,5,4,4,6,4,2,4,4,6,3,3,7,4];%The list of number of existed buildings in each station (1,2,...,7) in order.

% 2. ET: Existed Track Form (Direction Sensitive)
% If the track's direction is not decided, then first assume it to be 0,
% after we find the optimal solution, if there's repeated track, delete it and delete the repeated cost.
ET_case1 = [0,1,0,0,1,0,0,0,0,0,0,0,0,0;
            1,0,1,0,0,0,1,0,0,0,0,0,0,0;
            0,1,0,1,0,0,0,0,0,0,0,0,0,0;
            0,0,1,0,0,0,0,0,0,1,0,0,0,0;
            0,1,0,0,0,0,0,0,1,0,0,0,0,0;
            0,0,0,0,0,0,0,1,0,0,0,0,0,0;
            0,0,0,0,0,1,0,0,0,0,0,0,0,0;
            0,0,0,0,0,1,0,0,0,1,0,0,0,0;
            0,0,0,0,0,0,0,0,0,0,0,1,0,0;
            0,0,0,1,0,0,0,1,0,0,0,0,1,0;
            0,0,0,0,0,0,0,0,0,0,0,0,0,1;
            0,0,0,0,0,0,0,0,0,0,1,0,0,0;
            0,0,0,0,0,0,0,0,0,1,0,0,0,0;
            0,0,0,0,0,0,0,0,0,0,0,0,1,0];%Case 1 existed track form, ET(i,j) = the number of tracks between station i and j.
  
% 3. EW: Existed Way Form (In the future, we could add some cal code for t)
EW_case1 = [0,1,0,0,1,0,0,0,0,0,0,0,0,0;
            1,0,1,0,1,0,1,0,0,0,0,0,0,0;
            0,1,0,1,0,0,0,0,0,0,0,0,0,0;
            0,0,1,0,0,0,0,0,0,1,0,0,0,0;
            1,1,0,0,0,0,0,0,1,0,0,0,0,0;
            0,0,0,0,0,0,1,1,0,0,0,0,0,0;
            0,1,0,0,0,1,0,0,0,0,0,0,0,0;
            0,0,0,0,0,1,0,0,0,1,0,0,0,0;
            0,0,0,0,1,0,0,0,0,0,0,1,0,0;
            0,0,0,1,0,0,0,1,0,0,0,0,1,0;
            0,0,0,0,0,0,0,0,0,0,0,1,0,1;
            0,0,0,0,0,0,0,0,1,0,1,0,0,0;
            0,0,0,0,0,0,0,0,0,1,0,0,0,1;
            0,0,0,0,0,0,0,0,0,0,1,0,1,0];%Note EW is always symmetric, i.e. EW=EW'
  
% 4. EP_A: After Phase I, Existed Path Volume for Shipment A, 2 units
% remaining 1
%    EP_B: After Phase I, Existed Path Volume for Shipment B 
%    EP_C: After Phase I, Existed Path Volume for Shipment C, 6 units remaining 
EP_A_case1 = [0,10,0 ,0 ,5,0,0,0,0,0 ,0,0,0 ,0;
              0,0 ,10,0 ,0,0,0,0,0,0 ,0,0,0 ,0;
              0,0 ,0 ,10,0,0,0,0,0,0 ,0,0,0 ,0;
              0,0 ,0 ,0 ,0,0,0,0,0,10,0,0,0 ,0;
              0,0 ,0 ,0 ,0,0,0,0,5,0 ,0,0,0 ,0;
              0,0 ,0 ,0 ,0,0,0,0,0,0 ,0,0,0 ,0;
              0,0 ,0 ,0 ,0,0,0,0,0,0 ,0,0,0 ,0;
              0,0 ,0 ,0 ,0,0,0,0,0,0 ,0,0,0 ,0;
              0,0 ,0 ,0 ,0,0,0,0,0,0 ,0,5,0 ,0;
              0,0 ,0 ,0 ,0,0,0,0,0,0 ,0,0,10,0;
              0,0 ,0 ,0 ,0,0,0,0,0,0 ,0,0,0 ,5;
              0,0 ,0 ,0 ,0,0,0,0,0,0 ,5,0,0 ,0;
              0,0 ,0 ,0 ,0,0,0,0,0,0 ,0,0,0 ,0;
              0,0 ,0 ,0 ,0,0,0,0,0,0 ,0,0,5 ,0];
          
EP_B_case1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,8,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,8,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,8,0,0,0,0,0,0;
              0,0,0,0,0,8,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,8,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0];
          
EP_C_case1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,2,0,0;
              0,0,0,2,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,2;
              0,0,0,0,0,0,0,0,0,0,2,0,0,0;
              0,0,0,0,0,0,0,0,0,2,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,2,0];
          
EP_D_case1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0];
          
EP_E_case1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,6,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,6,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0,0,0,0,0,0,6,0,0,0,0;
              0,0,0,0,0,0,0,0,0,0,0,0,0,0];
          
EP_F_case1 = [0,0,0,0 ,0,0,0,0,0,0,0,0,0,0;
              8,0,0,0 ,0,0,0,0,0,0,0,0,0,0;
              0,8,0,0 ,0,0,0,0,0,0,0,0,0,0;
              0,0,8,0 ,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0 ,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0 ,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0 ,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0 ,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0 ,0,0,0,0,0,0,0,0,0,0;
              0,0,0,8 ,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0 ,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0 ,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0 ,0,0,0,0,0,0,0,0,0,0;
              0,0,0,0 ,0,0,0,0,0,0,0,0,0,0];
          
EP_case1 = EP_A_case1 + EP_B_case1 + EP_C_case1 + EP_D_case1 + EP_E_case1 + EP_F_case1;
          
% 5. ESV_A: Existed Station Volume for Shipment A
%    ESV_B: Existed Station Volume for Shipment B
ESV_A_case1 = [15,10,10,10,5,0,0,0,5,10,5,5,15,5];
ESV_B_case1 = [0,8,0,0 ,8,8 ,8,8,0,8,0,0,0,0];
ESV_C_case1 = [0,0,0,2,0,0,0,0,2,2,2,2,2,2];
ESV_D_case1 = [0,0,0,0 ,0,0 ,0,0,0,0,0,0,0,0];
ESV_E_case1 = [0,0,0,0,0,6,0,6,0,6,0,0,6,0];
ESV_F_case1 = [8,8,8,8 ,0,0 ,0,0,0,8,0,0,0,0];

ESV_case1 = ESV_A_case1 + ESV_B_case1 + ESV_C_case1 + ESV_D_case1 + ESV_E_case1 + ESV_F_case1;

% 6. PL: Path Limit (Maximal Volume)
PL_case1 = 10;
    
% 7. SL: Station Limit (Maximal Volume)
SL_case1 = 5;

% 8. Ct: Cost of track. ($/per mile)
Ct_case1 = 5000;

% 9. Cp: cost of Paving. ($/per mile)
Cp_case1 = 7000;

% 10. Cr: Cost of reloading station. ($/per station)
Cr_case1 = 500000;
  
% 11. L: limit for paving miles
L_case1 = 220;

%calculate the distance between i and j, create Dst matrix
for i=1:length(ESLx_case1)
    for j=1:length(ESLx_case1)
        Dst_case1(i,j)=sqrt((ESLx_case1(i)-ESLx_case1(j))^2+(ESLy_case1(i)-ESLy_case1(j))^2);
    end
end


%u=8;% Input the unit you want to ship.
%start=6;% Input the start point.
%e=3;% Input end point.

u=7;% Input the unit you want to ship.
start=14;% Input the starting point.
k=0;% Input the intermidiate points going through
e=3;% Input end point.

% Intialize the step 1 stored variable.
cost_step=[];
EW_step={};
ET_step={};
EB_step={};
EP_step={};
ESV_step={};
EW_new={};
ET_new={};
EB_new={};
EP_new={};
ESV_new={};

for k=0:length(ESLx_case1)-2 %We don't need to go to more steps than that, otherwise must have repeated points or self loops.
    % Step 1, calculate and store all the possible starting point s to destination e, going through 0 point.
    if k == 0
        for s=1:length(ESLx_case1)
            if s ~= e
                [cost_new,EW_new,ET_new,EB_new,EP_new,ESV_new] = OptCost(u,s,k,e,Dst_case1,EW_case1,ET_case1,EB_case1,PL_case1,SL_case1,EP_case1,ESV_case1,Ct_case1,Cp_case1,Cr_case1,L_case1);
        %                                                                u,s,k,e,Dst,      EW,      ET,      EB,PL,SL,EP,ESV,Ct,Cp,Cr,L
                cost_step(k+1,s) = cost_new;
            else
                cost_step(k+1,s) = 10^10;% big cost means it's impossible

            end
            EW_step{k+1,s} = EW_new;
            ET_step{k+1,s} = ET_new;
            EB_step{k+1,s} = EB_new;
            EP_step{k+1,s} = EP_new;
            ESV_step{k+1,s} = ESV_new;

        end
        % [mi,i]=min(cost_step1);

    % Step 2,3... and so on; calculate and store all the possible starting point s to destination e, going through 1 point.
    else
        for s=1:length(ESLx_case1)
            ESV_step_temp=ESV_step;

            % cal start from s to e, through 1 point, which is the best
            if s ~= e
                for inter=1:length(ESLx_case1)
                    if (inter ~= e)&&(inter ~= s)
                        ESV_step_temp{k,inter}(inter) = ESV_step{k,inter}(inter)-u;% to make sure that for the intermedirate point, count new ESV only once.
                        [cost_new,EW_new,ET_new,EB_new,EP_new,ESV_new]=OptCost(u,s,0,inter,Dst_case1,EW_step{k,inter},ET_step{k,inter},EB_step{k,inter},PL_case1,SL_case1,EP_step{k,inter},ESV_step_temp{k,inter},Ct_case1,Cp_case1,Cr_case1,L_case1);
                        %                                               u,s,k,e,Dst,      EW,      ET,      EB,PL,SL,EP,ESV,Ct,Cp,Cr,L
%                         if (k==1) && (s==7) && (inter == 3)
%                             Etest=EP_new
%                         end
                        cost_temp1(inter) = cost_new+cost_step(k,inter);%New cost is the cost from s to inter plus the minimal cost from inter to e.
                    else
                        cost_temp1(inter) = 10^10+cost_step(k,inter);%big cost means it's impossible
                    end 
                end
                [cost_step(k+1,s),i] = min(cost_temp1);%find the lowest cost and the corresponding route.

                %After knowing the best inter point i, we can find the best plan and record it
                [cost_new,EW_new,ET_new,EB_new,EP_new,ESV_new]=OptCost(u,s,0,i,Dst_case1,EW_step{k,i},ET_step{k,i},EB_step{k,i},PL_case1,SL_case1,EP_step{k,i},ESV_step_temp{k,i},Ct_case1,Cp_case1,Cr_case1,L_case1);

                EW_step{k+1,s} = EW_new;%give the lowest cost route for starting from s to e, going through k points.
                ET_step{k+1,s} = ET_new;
                EB_step{k+1,s} = EB_new;
                EP_step{k+1,s} = EP_new;
                ESV_step{k+1,s} = ESV_new;
            else
                cost_step(k+1,s) = 10^10;%big cost means it's impossible
            end        
        end
    end
end


disp('First step, ship 7 units D from station 14 to station 3')

%Display the minimal cost from starting point to the endpoint
[MinCost1,CIndex]=min(cost_step(:,start)); 
MinCost1

%Display the updated Reoloading Stations, EB.
disp('First step, the updated Reoloading Stations')
EB_case2=EB_step{CIndex,start}

%Display the Reoloading changes, delta~EB.
disp('First step, the Reoloading Station changes')
EB_step{CIndex,start}-EB_case1

%Display the updated Way Pavements, EW.
disp('First step, the updated Way Pavements')
EW_case2=EW_step{CIndex,start}

%Display the Way Pavement changes, delta~EW.
disp('First step, the Way Pavement changes')
EW_step{CIndex,start}-EW_case1

%Display the updated Tracks, ET.
disp('First step, the updated Tracks')
ET_case2=ET_step{CIndex,start}

%Display the Track changes, delta~ET.
disp('First step, the Track changes')
ET_step{CIndex,start}-ET_case1



