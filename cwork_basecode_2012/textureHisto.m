function F = textureHisto(img)
greyscaledImage = rgb2gray(img);
sobelX = [1 0 -1; 2 0 -2; 1 0 -1];
sobelY = [1 2 1; 0 0 0; -1 -2 -1];

ImageX = conv2(im2double(greyscaledImage), sobelX, 'same');
ImageY = conv2(im2double(greyscaledImage), sobelY, 'same');
sobelMagImage = sqrt(ImageX.^2 + ImageY.^2);
sobelThetaImage = mod(atan2(ImageY, ImageX), 2*pi);
sobelThetaImage = normalize(sobelThetaImage, 'range');

height = size(greyscaledImage,1);
width = size(greyscaledImage, 2);
gridX = 8;
gridY = 6;
avgCellWidth = width./gridX;
avgCellHeight = floor(height./gridY);
widthR = mod(width, gridX);
heightR = mod(height, gridY);

for j = 1:avgCellHeight
    
end    


Theta1 = sobelThetaImage(1:avgCellHeight, 1:avgCellWidth);
Theta2 = sobelThetaImage(1:avgCellHeight, (avgCellWidth+1):avgCellWidth*2);
imgshow(Theta1);
imgshow(Theta2);

% for row=2:(height-1)
%    for column=2:(width-1)
%       tmp3x3 = greyscaledImage(row-1:row+1, column-1:column+1);
%       newPixelValueX = sum(sum(sobelX.*tmp3x3));
%       newPixelValueY = sum(sum(sobelY.*tmp3x3));
%       sobelMagPixel = sqrt(newPixelValueX.^2 + newPixelValueY.^2);
%       sobelThetaPixel = mod(atan2(newPixelValueY, newPixelValueX), 2*pi);
%       sobelMagImage(row,column) = sobelMagPixel;
%       sobelThetaImage(row,column) = sobelThetaPixel;
%    end    
% end 

%%Grid image
%%Create textureHisto for each cell in the grid
%%Join all histos into one long descriptor
return;
end

