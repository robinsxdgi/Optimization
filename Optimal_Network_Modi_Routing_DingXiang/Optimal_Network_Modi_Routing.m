%Transmit u units from station s to e, through k points, calculate the minimal cost plan.
%Note: to use this function, we need to make sure the intial state is feasible.

function [cost_new,EW_new,ET_new,EB_new,EP_new,ESV_new] = OptCost(u,s,k,e,Dst,EW,ET,EB,PL,SL,EP,ESV,Ct,Cp,Cr,L)%EB: Existed Building; ET: Existed Track; PV: Path & Path Volume
%Set the initial value of updated variables
cost_new = 0;
EW_new = EW;
ET_new = ET;
EB_new = EB;
EP_new = EP;
ESV_new = ESV;

if s ~= e
    %Whether pave a way
    if EW(s,e) == 0
        if Dst(s,e) <= L
            EW_new(s,e) = 1;
            cost_new = Cp*Dst(s,e);

            %Whether build a new track
            if u+EP(s,e) > ET(s,e)*PL %New shipment will lead to overflow on tracks.
                ET_new(s,e) = ET(s,e)+1; %Add a new track; note we assume u <= 10;
                cost_new = cost_new + Ct*Dst(s,e);
            end

            %Whether build a new reloading station
            if u+ESV(s) > EB(s)*SL %New shipment will lead to overflow in reloading stations.
                EB_new(s) = ceil((u+ESV(s))/SL); %Add a new reloading station; note we assume u <= 10;
                cost_new = cost_new + Cr*(ceil((u+ESV(s))/SL)-EB(s));
            end
            if u+ESV(e) > EB(e)*SL %New shipment will lead to overflow in reloading stations.
            EB_new(e) = ceil((u+ESV(e))/SL); %Add a new reloading station; note we assume u <= 10;
            cost_new = cost_new + Cr*(ceil((u+ESV(e))/SL)-EB(e));
            end
            
            %Update the EP
            EP_new(s,e) = EP(s,e)+u;
            
            %Update the ESV
            ESV_new(s) = ESV(s)+u;
            ESV_new(e) = ESV(e)+u;

        else
            EW_new(s,e) = 99; %give it a big number to show it's out of the mile limit, here we use 99 as a sign.
            cost_new = 10^10; %Use a big number to show this is impossible.
        end
    elseif EW(s,e) == 1
        %Whether build a new track
        if u+EP(s,e) > ET(s,e)*PL %New shipment will lead to overflow on tracks.
            ET_new(s,e) = ET(s,e)+1; %Add a new track; note we assume u <= 10;
            cost_new = cost_new + Ct*Dst(s,e);
        end

        %Whether build a new reloading station
        if u+ESV(s) > EB(s)*SL %New shipment will lead to overflow in reloading stations.
            EB_new(s) = ceil((u+ESV(s))/SL); %Add a new reloading station; note we assume u <= 10;
            cost_new = cost_new + Cr*(ceil((u+ESV(s))/SL)-EB(s));
        end
        if u+ESV(e) > EB(e)*SL %New shipment will lead to overflow in reloading stations.
            EB_new(e) = ceil((u+ESV(e))/SL); %Add a new reloading station; note we assume u <= 10;
            cost_new = cost_new + Cr*(ceil((u+ESV(e))/SL)-EB(e));
        end
        
        %Update the EP
        EP_new(s,e) = EP(s,e)+u;
        
        %Update the ESV
        ESV_new(s) = ESV(s)+u;
        ESV_new(e) = ESV(e)+u;
    end
end
    
end