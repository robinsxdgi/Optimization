% Agent x constraints for all nodes except for node 0, root node.
function [ cx, ceqx ] = Agentxcon(x,vimin,vimax,pimin,pimax,qimin,qimax)
cx = [x(1)^2+x(2)^2-x(3)*x(4);
    x(4)-vimax;
    vimin-x(4);
    x(5)-pimax;
    pimin-x(5);
    x(6)-qimax;
    qimin-x(6)];
ceqx =[];
end

