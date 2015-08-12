function F = part2_1(ptsA, ptsB)
n = size(ptsA,1);
A = zeros(n,9);

for i=1:n
    ua = ptsA(i,1);
    va = ptsA(i,2);
    ub = ptsB(i,1);
    vb = ptsB(i,2);
    A(i,:) = [ub*ua ub*va ub vb*ua vb*va vb ua va 1];    
end
[~, ~, V] = svd(A);
f = V(:,9);
F = reshape(f, 3, 3)';

end