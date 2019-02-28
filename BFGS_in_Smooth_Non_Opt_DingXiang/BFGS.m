%Problem 3 (b)

% [X, Y] = meshgrid(-2:0.01:2);
% Z = 10 .* (Y - X.^2).^2 + (1 - X).^2;
% contour(X,Y,Z,20)
% hold on
% 
% k = 1;
% x0= [-0.9, 1.7]';
% H0= eye(2,2);
% tolerance=1e-9;
% max_iter=1000;
% x{1} = x0;
% H{1} = H0;
% I = eye(2,2);
% max_line_iter = 20;
% while norm(gf1(x{k}(1), x{k}(2))) > tolerance && k < max_iter
%     log_df(k) = log(f1(x{k}(1), x{k}(2)) - 0);% Store the distance from f(x_k) to f*
%     p{k} = - H{k} * gf1(x{k}(1), x{k}(2));
%     alpha(k) = awline1(x{k}, p{k}, max_line_iter)
%     if alpha(k) == -999
%         break
%     else
%         x{k+1} = x{k} + alpha(k) * p{k};
%         s{k} = alpha(k) * p{k};
%         y{k} = gf1(x{k+1}(1), x{k+1}(2)) - gf1(x{k}(1), x{k}(2));
%         H{k+1} = (I - (s{k} * y{k}') / (s{k}' * y{k}) ) * H{k} * (I - (y{k} * s{k}') / (s{k}' * y{k}) ) + (s{k} * s{k}') / (s{k}' * y{k});
%         k = k + 1;
%     end
%     quiver(x{k-1}(1),x{k-1}(2),x{k}(1)-x{k-1}(1),x{k}(2)-x{k-1}(2),'LineWidth',2)
% end
% x_min = x{k};
% % quiver(-2,1,4,0,'r')
% 
% %
% % [X, Y] = meshgrid(-5:0.1:5);
% % Z = 10 .* (Y - X.^2).^2 + (1 - X).^2;
% % surf(X,Y,Z)
% % hold on
% % quiver3(-2,1,0,4,0,0,'r')


%Problem 3 (b)

[X, Y] = meshgrid(-2:0.01:2);
Z = 10 .* abs(Y - X.^2) + (1 - X).^2;
contour(X,Y,Z,20)
hold on

k = 1;
x0= [-0.9, 1.7]';
H0= eye(2,2);
tolerance=1e-9;
max_iter=1000;
x{1} = x0;
H{1} = H0;
I = eye(2,2);
max_line_iter = 20;
while norm(gf2(x{k}(1), x{k}(2))) > tolerance && k < max_iter
    log_df(k) = log(f2(x{k}(1), x{k}(2)) - 0);% Store the distance from f(x_k) to f*
    p{k} = - H{k} * gf2(x{k}(1), x{k}(2));
    alpha(k) = awline2(x{k}, p{k}, max_line_iter)
    if alpha(k) == -999
        break
    else
        x{k+1} = x{k} + alpha(k) * p{k};
        s{k} = alpha(k) * p{k};
        y{k} = gf2(x{k+1}(1), x{k+1}(2)) - gf2(x{k}(1), x{k}(2));
        H{k+1} = (I - (s{k} * y{k}') / (s{k}' * y{k}) ) * H{k} * (I - (y{k} * s{k}') / (s{k}' * y{k}) ) + (s{k} * s{k}') / (s{k}' * y{k});
        k = k + 1;
    end
    quiver(x{k-1}(1),x{k-1}(2),x{k}(1)-x{k-1}(1),x{k}(2)-x{k-1}(2),'LineWidth',2)
end
x_min = x{k};