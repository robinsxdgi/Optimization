function G = Agentyobj(y,PPi,QQi,li,vi,spi,qi,uii,uiAi,uij1,uij2,ro,Nci)
%y1,y2 : PPii, QQii
%y3 : lii
%y4 : vii
%y5,y6 : pii, qii
%y7 :viAi
%y8~y16 : PPij
%y17~y25 : QQij
%y26~y34 : lij
%uii is a vector 4*1
%uij1, uij2 are vectors in this case 9*1
G= -(uii(1)*y(1)+uii(2)*y(3)+uii(3)*y(4)+uii(4)*y(5)) + ro/2*((PPi-y(1))^2+(QQi-y(2))^2+(li-y(3))^2+(vi-y(4))^2+(spi-y(5))^2+(qi-y(6))^2) - (uiAi*y(7)) + ro/2*((vi-y(7))^2) - sum(uij1.*y(8:16)+uij2.*y(26:34)) + ro/2*((Nci*(PPi^2+QQi^2+li^2)) - 2*PPi*sum(y(8:16)) -2*QQi*sum(y(17:25))- 2*li*sum(y(26:34)) + sum(y(8:16).^2+y(17:25).^2+y(26:34).^2));

end