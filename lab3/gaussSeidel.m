function [iter, resArr] = gaussSeidel(N, M, b)
    iter=0;
    r = ones(N, 1);
    res = norm(M*r-b);

    U = triu(M, 1);
    L = tril(M, -1);
    D = diag(diag(M));
    part1 = -(D+L);
    part2 = (D+L)\b;

    % obliczenia start
    tic
    while ((res) > 10e-14)
        r = part1\(U*r)+part2;
        res = norm(M*r-b);
        iter= iter+ 1;
        resArr(iter) = res;
    end
end