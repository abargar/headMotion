function [Fnorm TA TB] = part2_4(pointsA, pointsB)

TA = createTransformMatrix(pointsA)
TB = createTransformMatrix(pointsB)
pointsAnorm = zeros(size(pointsA,1),3);
pointsBnorm = zeros(size(pointsB,1),3);
for i=1:20
    pointsAnorm(i,:) = TA*[pointsA(i,:) 1]';
    pointsBnorm(i,:) = TA*[pointsB(i,:) 1]';
end
Fnorm = part2_2(part2_1(pointsAnorm, pointsBnorm));


end