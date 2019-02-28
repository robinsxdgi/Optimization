% Agent y constraints for all nodes except for node 0, root node.
function [ cy, ceqy ] = Agentycon(y,ri,xi,rj,xj,i)
%y1,y2 : PPii, QQii
%y3 : lii
%y4 : vii
%y5,y6 : pii, qii
%y7 :viAi
%y8~y16 : PPij
%y17~y25 : QQij
%y26~y34 : lij
%uii is a vector 4*1
%uij1, uij2,rj,xj are vectors in this case 9*1
switch i
    case 2
        ceqy = [y(7)-y(4)+2*ri*y(1)+2*xi*y(2)-y(3)*(ri^2+xi^2);
                sum(y(8:16))-sum(rj.*y(26:34))-y(1)+y(5);
                sum(y(17:25))-sum(xj.*y(26:34))-y(2)+y(6);
                y(8);
                y(9)-y(10);
                y(11:16);
                y(17);
                y(18)-y(19);
                y(20:25);
                y(26);
                y(27)-y(28);
                y(29:34);
                ];
    case 3
        ceqy = [y(7)-y(4)+2*ri*y(1)+2*xi*y(2)-y(3)*(ri^2+xi^2);
                sum(y(8:16))-sum(rj.*y(26:34))-y(1)+y(5);
                sum(y(17:25))-sum(xj.*y(26:34))-y(2)+y(6);
                y(8:34);
                ];
    case 4
        ceqy = [y(7)-y(4)+2*ri*y(1)+2*xi*y(2)-y(3)*(ri^2+xi^2);
                sum(y(8:16))-sum(rj.*y(26:34))-y(1)+y(5);
                sum(y(17:25))-sum(xj.*y(26:34))-y(2)+y(6);
                y(8:10);
                y(11)-y(12);
                y(12)-y(13);
                y(14:16);
                y(17:19);
                y(20)-y(21);
                y(21)-y(22);
                y(23:25);
                y(26:28);
                y(29)-y(30);
                y(30)-y(31);
                y(32:34);
                ];
    case 5
        ceqy = [y(7)-y(4)+2*ri*y(1)+2*xi*y(2)-y(3)*(ri^2+xi^2);
                sum(y(8:16))-sum(rj.*y(26:34))-y(1)+y(5);
                sum(y(17:25))-sum(xj.*y(26:34))-y(2)+y(6);
                y(8:34);
                ];
    case 6
        ceqy = [y(7)-y(4)+2*ri*y(1)+2*xi*y(2)-y(3)*(ri^2+xi^2);
                sum(y(8:16))-sum(rj.*y(26:34))-y(1)+y(5);
                sum(y(17:25))-sum(xj.*y(26:34))-y(2)+y(6);
                y(8:34);
                ];
    case 7
        ceqy = [y(7)-y(4)+2*ri*y(1)+2*xi*y(2)-y(3)*(ri^2+xi^2);
                sum(y(8:16))-sum(rj.*y(26:34))-y(1)+y(5);
                sum(y(17:25))-sum(xj.*y(26:34))-y(2)+y(6);
                y(8:13);
                y(15:16);
                y(17:22);
                y(24:25);
                y(26:31);
                y(33:34);
                ];
    case 8
        ceqy = [y(7)-y(4)+2*ri*y(1)+2*xi*y(2)-y(3)*(ri^2+xi^2);
                sum(y(8:16))-sum(rj.*y(26:34))-y(1)+y(5);
                sum(y(17:25))-sum(xj.*y(26:34))-y(2)+y(6);
                y(8:14);
                y(15)-y(16);
                y(17:23);
                y(24)-y(25);
                y(26:32);
                y(33)-y(34);
                ];
    case 9
        ceqy = [y(7)-y(4)+2*ri*y(1)+2*xi*y(2)-y(3)*(ri^2+xi^2);
                sum(y(8:16))-sum(rj.*y(26:34))-y(1)+y(5);
                sum(y(17:25))-sum(xj.*y(26:34))-y(2)+y(6);
                y(8:34);
                ];
    case 10
        ceqy = [y(7)-y(4)+2*ri*y(1)+2*xi*y(2)-y(3)*(ri^2+xi^2);
                sum(y(8:16))-sum(rj.*y(26:34))-y(1)+y(5);
                sum(y(17:25))-sum(xj.*y(26:34))-y(2)+y(6);
                y(8:34);
                ];
end
            
            
cy=[];
end

