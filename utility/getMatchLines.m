function matchLines = getMatchLines(matches, framesA, framesB)

numMatches = size(matches,2);

matchLines = zeros(numMatches*2,2);
for m = 1:numMatches
    m1 = matches(1,m);
    m2 = matches(2,m);
    matchLines(2*m-1,1:2) = framesA(1:2,m1);
    matchLines(2*m,1:2) = framesB(1:2,m2);
end

end