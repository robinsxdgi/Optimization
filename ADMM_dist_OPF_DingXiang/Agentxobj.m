function H = Agentxobj(x,PPii,QQii,lii,vii,pii,qii,viAi,PPij,QQij,lij,uii,uiAi,uij1,uij2,ro,Nci)
%x1,x2,x3,x4,x5,x6 corresponds to P,Q,l,v,p,q respectively.
%uii is a vector 4*1.
%PPij,QQij,lij,uij1,uij2 are both vectors, s.t. j in Ai & 9*1 vector in this case. If there's no
%connection then the corresponding element becomes 0.

H=x(5)-((uii(1)*x(1)+uii(2)*x(3)+uii(3)*x(4)+uii(4)*x(5))+ (uiAi*x(4)) + ((x(1)*sum(uij1)) + (x(3)*sum(uij2)))) + ro/2*((x(1)-PPii)^2+(x(2)-QQii)^2+(x(3)-lii)^2+(x(4)-vii)^2+(x(5)-pii)^2+(x(6)-qii)^2) + ro/2*(x(4)-viAi)^2 + ro/2*(Nci*(x(1)^2+x(2)^2+x(3)^2) - 2*x(1)*sum(PPij) -2*x(2)*sum(QQij)- 2*x(3)*sum(lij) + sum(PPij.^2+QQij.^2+lij.^2));
end