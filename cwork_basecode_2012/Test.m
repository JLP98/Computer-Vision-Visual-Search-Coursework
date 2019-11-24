numOfImages = 20;
pLine = zeros(1, numOfImages);
rLine = zeros(1, numOfImages);
for i = 1:numOfImages
    prMatrix = visualSearchTest(i);
    pLine(1,i) = prMatrix(1);
    rLine(1,i) = prMatrix(2);
    disp(numOfImages - i);
end
scatter(rLine,pLine,'filled', 'd');
xlabel('Recall');
ylabel('Precision');
xlim([0 1]);
ylim([0 1]);