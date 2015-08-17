function F = enforceRank2(F)
[U, D, V] = svd(F);
%rank(D)
copyD = D;
copyD(~D) = inf;
[minI, minJ] = find(D == min(copyD(:)));
D(minI, minJ) = 0;
%rank(D)
F = U*D*V';
end