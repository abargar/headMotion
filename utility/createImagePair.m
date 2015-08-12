function imagePair = createImagePair(imageA, imageB)

imagePair = zeros(size(imageA,1), size(imageA,2)*2);
rowsA = size(imageA,1);
colsA = size(imageA,2);
imagePair(1:rowsA,1:colsA) = imageA(1:rowsA,1:colsA);
imagePair(1:rowsA,colsA+1:2*colsA) = imageB(1:rowsA,1:colsA);

end