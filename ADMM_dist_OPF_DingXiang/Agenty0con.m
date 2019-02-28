% Agent y constraints for node 0, root node.
function [ cy, ceqy ] = Agenty0con(y,ri,xi,rj,xj)
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
ceqy = [sum(y(8:16))-sum(rj.*y(26:34))+y(5);
        sum(y(17:25))-sum(xj.*y(26:34))+y(6);
        y(1);
        y(2);
        y(3);
        y(7);
        y(8:16);
        y(17:25);
        y(26:34);
        ];
cy=[];
end

