% For HW4 problem 3(a)
% this is for line search with second function
function alpha = awline2(x_k, p_k, max_iter)
    n = 0;
    alpha_l = 0;
    alpha_u = inf;
    alpha = 1;
    c1 = 1e-4;
    c2 = 0.5;
    
    while n < max_iter
        if f2(x_k(1) + alpha * p_k(1), x_k(2) + alpha * p_k(2)) > f2(x_k(1), x_k(2)) + c1 * alpha * (p_k' * gf2(x_k(1), x_k(2)))
            alpha_u = alpha;
        elseif p_k' * gf2(x_k(1) + alpha * p_k(1), x_k(2) + alpha * p_k(2)) < c2 * (p_k' * gf2(x_k(1), x_k(2)))
            alpha_l = alpha;
        else
            break
        end
        
        if alpha_u < inf
            alpha = (alpha_l + alpha_u) / 2;
        else
            alpha = 2 * alpha_l;
        end
        n = n + 1;
    end
    
    if n == max_iter
        alpha = -999; % meaning line search failed
    end
end