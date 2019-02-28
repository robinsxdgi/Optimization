% 1. EB: Existed Building Form
EB_case2 = EB_step{CIndex,start};%The list of number of existed buildings in each station (1,2,...,7) in order.

% 2. ET: Existed Track Form (Direction Sensitive)
ET_case2 = ET_step{CIndex,start};%Case 1 existed track form, ET(i,j) = the number of tracks between station i and j.
  
% 3. EW: Existed Way Form (In the future, we could add some cal code for t)
EW_case2 = EW_step{CIndex,start};%Note EW is always symmetric, i.e. EW=EW'
  
% 4. EP_A: Existed Path Volume for Shipment A
%    EP_B: Existed Path Volume for Shipment B           
EP_case2 = EP_step{CIndex,start};
          
% 5. ESV_A: Existed Station Volume for Shipment A
%    ESV_B: Existed Station Volume for Shipment B
ESV_case2 = ESV_step{CIndex,start};

u=6;% Input the unit you want to ship.
start=9;% Input the starting point.
k=0;% Input the intermidiate points going through
e=4;% Input end point.

% u=8;% Input the unit you want to ship.
% s=6;% Input the start point.
% e=3;% Input end point.

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
        for start=1:length(ESLx_case1)
            if start ~= e
                [cost_new,EW_new,ET_new,EB_new,EP_new,ESV_new]=OptCost(u,start,k,e,Dst_case1,EW_case2,ET_case2,EB_case2,PL_case1,SL_case1,EP_case2,ESV_case2,Ct_case1,Cp_case1,Cr_case1,L_case1);
        %                                               u,s,k,e,Dst,      EW,      ET,      EB,PL,SL,EP,ESV,Ct,Cp,Cr,L
                cost_step(k+1,start) = cost_new;
            else
                cost_step(k+1,start) = 10^10;% big cost means it's impossible

            end
            EW_step{k+1,start} = EW_new;
            ET_step{k+1,start} = ET_new;
            EB_step{k+1,start} = EB_new;
            EP_step{k+1,start} = EP_new;
            ESV_step{k+1,start} = ESV_new;

        end
        % [mi,i]=min(cost_step1);

    % Step 2,3... and so on; calculate and store all the possible starting point s to destination e, going through 1 point.
    else
        for start=1:length(ESLx_case1)
            ESV_step_temp=ESV_step;

            % cal start from s to e, through 1 point, which is the best
            if start ~= e
                for inter=1:length(ESLx_case1)
                    if (inter ~= e)&&(inter ~= start)
                        ESV_step_temp{k,inter}(inter) = ESV_step{k,inter}(inter)-u;% to make sure that for the intermedirate point, count new ESV only once.
                        [cost_new,EW_new,ET_new,EB_new,EP_new,ESV_new]=OptCost(u,start,0,inter,Dst_case1,EW_step{k,inter},ET_step{k,inter},EB_step{k,inter},PL_case1,SL_case1,EP_step{k,inter},ESV_step_temp{k,inter},Ct_case1,Cp_case1,Cr_case1,L_case1);
                        %                                               u,s,k,e,Dst,      EW,      ET,      EB,PL,SL,EP,ESV,Ct,Cp,Cr,L
                        cost_temp1(inter) = cost_new+cost_step(k,inter);%New cost is the cost from s to inter plus the minimal cost from inter to e.
                    else
                        cost_temp1(inter) = 10^10+cost_step(k,inter);%big cost means it's impossible
                    end 
                end
                [cost_step(k+1,start),i] = min(cost_temp1);%find the lowest cost and the corresponding route.

                %After knowing the best inter point i, we can find the best plan and record it
                [cost_new,EW_new,ET_new,EB_new,EP_new,ESV_new]=OptCost(u,start,0,i,Dst_case1,EW_step{k,i},ET_step{k,i},EB_step{k,i},PL_case1,SL_case1,EP_case2,ESV_step_temp{k,i},Ct_case1,Cp_case1,Cr_case1,L_case1);

                EW_step{k+1,start} = EW_new;%give the lowest cost route for starting from s to e, going through k points.
                ET_step{k+1,start} = ET_new;
                EB_step{k+1,start} = EB_new;
                EP_step{k+1,start} = EP_new;
                ESV_step{k+1,start} = ESV_new;
            else
                cost_step(k+1,start) = 10^10;%big cost means it's impossible
            end        
        end
    end
end

disp('Second step, ship 6 units C from station 9 to station 4')

%Display the minimal cost from starting point to the endpoint
[MinCost2,CIndex]=min(cost_step(:,start));
MinCost2

%Display the ultimate Reoloadings, EB.
disp('Second step, the updated Reoloading Stations')
EB_case3=EB_step{CIndex,start}

%Display the Reoloading changes, delta~EB.
disp('Second step, the Reoloading Station changes')
EB_step{CIndex,start}-EB_case2

%Display the ultimate Way Pavements, EW.
disp('Second step, the updated Way Pavements')
EW_case3=EW_step{CIndex,start}

%Display the Way Pavement changes, delta~EW.
disp('Second step, the Way Pavement changes')
EW_step{CIndex,start}-EW_case2

%Display the updated Tracks, ET.
disp('Second step, the updated Tracks')
ET_case3=ET_step{CIndex,start}

%Display the updated Tracks, delta~ET.
disp('Second step, the Track changes')
ET_step{CIndex,start}-ET_case2