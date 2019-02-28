% Agent x constraints for node 0, root node.
function [ cx, ceqx ] = Agentx0con(x,vimin,vimax,pimin,pimax,qimin,qimax)
cx = [x(4)-vimax;
    vimin-x(4);
    x(5)-pimax;
    pimin-x(5);
    x(6)-qimax;
    qimin-x(6)];
ceqx =[];
end

