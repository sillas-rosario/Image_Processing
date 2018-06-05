



%% Limiar  objetivo desse codigo é 
% separaçao por nivel , ou seja falando que T é 127
% todos valores acima de 127 receberao 255  equanto o restante sera 
% setado 0;

img = imread('lenna_gray.jpg');
T=100;

[lin,col] = size(img);
nimg = zeros(lin,col);
ind = img>=T;
% nimg(ind) = 255;

figure, imshow(img)
figure, imshow(nimg)

imwrite(out,'novaimagem.jpg')


%%

a=imread('esporos.jpg');
a=rgb2gray(a);
figure,imshow(a);
[r c]=ginput(4);
[BW ,xi,yi] =roipoly(a,r,c)
figure, imshow(BW);
[R C]=size(BW);



%%
for i=1:R
    for j=1:C
        if BW(i,j)==1
            Out(i,j)=a(i,j);
        else
            Out(i,j)=0;
        end
    end
end
figure,imshow(Out);
title('saida');