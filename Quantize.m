

% Função para quantizar em número de bits
function nimg = Quantize(img, nbits)
nbitsShift = 8 - nbits;
nimg = bitshift(img, -nbitsShift);
nimg = bitshift(nimg, nbitsShift);
figure,imshow(nimg)
nimg = uint8(Mapping(nimg));
figure,imshow(nimg)
% Função para escalonar os pixels entre 0 a 255 ou mapear de 0 a 255 qualquer escala de pixels
function nimg = Mapping(img)
nimg= double(img);
mmin= min(nimg(:));
nimg= nimg-mmin;
mmax= max(nimg(:));
nimg= (255 * nimg) / mmax; 
end
end



