%Test the Scenario 2 with connection to Heuristic Phase I.
%Data file.

% 0. ESLx: Existed Station Locations (x axis); 
%    ESLy: Existed Station Locations (y axis);
ESLx_case1 = [50,250,100, 0 ,200,100,200];
ESLy_case1 = [0 , 0 , 50,100,100,200,200];


% 1. EB: After Phase I, Existed Building Form
EB_case1 = [1,3,2,4,2,2,3];%The list of number of existed buildings in each station (1,2,...,7) in order.

% 2. ET: Existed Track Form (Direction Sensitive)
ET_case1 = [0,0,1,0,0,0,0;
            0,0,0,0,0,0,0;
            0,0,0,0,1,0,0;
            1,0,0,0,0,1,0;
            0,1,0,0,0,0,1;
            0,0,0,0,0,0,1;
            0,0,0,0,0,0,0];%Case 1 existed track form, ET(i,j) = the number of tracks between station i and j.
  
% 3. EW: Existed Way Form (In the future, we could add some cal code for t)
EW_case1 = [0,0,1,1,0,0,0;
            0,0,0,0,1,0,0;
            1,0,0,0,1,0,0;
            1,0,0,0,0,1,0;
            0,1,1,0,0,0,1;
            0,0,0,1,0,0,1;
            0,0,0,0,1,1,0];%Note EW is always symmetric, i.e. EW=EW'
  
% 4. EP_A: After Phase I, Existed Path Volume for Shipment A
%    EP_B: After Phase I, Existed Path Volume for Shipment B 
%    EP_C: After Phase I, Existed Path Volume for Shipment C 
EP_A_case1 = [0,0,1,0,0, 0, 0;
              0,0,0,0,0, 0, 0;
              0,0,0,0,1, 0, 0;
              1,0,0,0,0,10, 0;
              0,0,0,0,0, 0, 1;
              0,0,0,0,0, 0,10;
              0,0,0,0,0, 0, 0];
  
EP_B_case1 = [0,0,0,0,0,0,0;
              0,0,0,0,0,0,0;
              0,0,0,0,3,0,0;
              0,0,0,0,0,0,0;
              0,3,0,0,0,0,0;
              0,0,0,0,0,0,0;
              0,0,0,0,0,0,0];
          
EP_C_case1 = [0,0,4,0,0,0,0;
              0,0,0,0,0,0,0;
              0,0,0,0,4,0,0;
              4,0,0,0,0,0,0;
              0,4,0,0,0,0,0;
              0,0,0,0,0,0,0;
              0,0,0,0,0,0,0];
          
EP_case1 = EP_A_case1 + EP_B_case1 + EP_C_case1;
          
% 5. ESV_A: Existed Station Volume for Shipment A
%    ESV_B: Existed Station Volume for Shipment B
ESV_A_case1 = [1,0,1,11,1,11,11];
ESV_B_case1 = [0,3,3,0 ,3,0 ,0];
ESV_C_case1 = [4,4,4,4 ,4,0 ,0];
ESV_case1 = ESV_A_case1 + ESV_B_case1 + ESV_C_case1;

% 6. PL: Path Limit (Maximal Volume)
PL_case1 = 10;
    
% 7. SL: Station Limit (Maximal Volume)
SL_case1 = 5;

% 8. Ct: Cost of track. ($/per mile)
Ct_case1 = 5000;

% 9. Cp: cost of Paving. ($/per mile)
Cp_case1 = 7000;

% 10. Cr: Cost of reloading station. ($/per station)
Cr_case1 = 1000000;
  
% 11. L: limit for paving miles
L_case1 = 220;

%calculate the distance between i and j, create Dst matrix
for i=1:length(ESLx_case1)
    for j=1:length(ESLx_case1)
        Dst_case1(i,j)=sqrt((ESLx_case1(i)-ESLx_case1(j))^2+(ESLy_case1(i)-ESLy_case1(j))^2);
    end
end


u=5;% Input the unit you want to ship.
start=4;% Input the start point.
e=2;% Input end point.

% Intialize the step 1 stored variable.
cost_step=[];
EW_step={};
ET_step={};
EB_step={};
EP_step={};
ESV_step={};

for k=0:length(ESLx_case1)-2 %We don't need to go to more steps than that, otherwise must have repeated points or self loops.
    % Step 1, calculate and store all the possible starting point s to destination e, going through 0 point.
    if k == 0
        for s=1:length(ESLx_case1)
            if s ~= e
                [cost_new,EW_new,ET_new,EB_new,EP_new,ESV_new] = OptCost(u,s,k,e,Dst_case1,EW_case1,ET_case1,EB_case1,PL_case1,SL_case1,EP_case1,ESV_case1,Ct_case1,Cp_case1,Cr_case1,L_case1);
        %                                                                u,s,k,e,Dst,      EW,      ET,      EB,      PL,      SL,      EP,      ESV,      Ct,Cp,Cr,L
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

disp('Ship 5 units C from station 4 to station 2')

%Display the minimal cost from starting point to the endpoint
[MinCost,CIndex]=min(cost_step(:,start));
MinCost

%Display the ultimate Reoloadings, EB.
disp('The updated Reoloading Stations')
EB_step{CIndex,start}

%Display the Reoloading changes, delta~EB.
disp('The Reoloading Station changes')
EB_step{CIndex,start}-EB_case1

%Display the ultimate Way Pavements, EW.
disp('The updated Way Pavements')
EW_step{CIndex,start}

%Display the Way Pavement changes, delta~EW.
disp('The Way Pavement changes')
EW_step{CIndex,start}-EW_case1

%Display the updated Tracks, ET.
disp('The updated Tracks')
ET_step{CIndex,start}

%Display the Track changes, delta~ET.
disp('The Track changes')
ET_step{CIndex,start}-ET_case1
