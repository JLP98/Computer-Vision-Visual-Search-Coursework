function F=extractRandom(img)
Q=6;
qimg = double(img)./256;
qimg=floor(img.*Q)

bin = qimg(:,:,1)*Q^2 + qimg(:,:,2)*Q + qimg(:,:,3);
vals = reshape(bin, 1, size(bin,1) * size(bin,2));

H=hist(vals, Q^3);
F = H./sum(H);

return;