%% 4 semana parte II

% Converta uma imagem colorida para tons de cinza (luminância). Uma imagem em tons de
% cinza pode ser obtida a partir de uma imagem colorida aplicando-se a seguinte fórmula para
% cada um dos pixels da imagem original: L = 0.299*R + 0.587*G + 0.114*B, onde R, G e B
% são as componentes de cor do pixel original. Ao criar uma imagem a ser exibida em tons de
% cinza, para cada pixel.

% Imgame colorida:
J=imread('board.tif');
figure,imshow(J)

% escala de cinza:
T = rgb2gray(J);
figure,imshow(T)

% criando a partir da formula 
R = J(:,:,1);
G = J(:,:,2);
B = J(:,:,3);
%indices de bayer
a = 0.299;
b = 0.587;
c = 0.114;

Y = a*R + b*G + c*B;
figure,imshow(Y)

% Apliocando a media:

[l,c]=size(J);
G=zeros(l,c/3);
for i=1:1:l
     for j=1:1:(c/3)
         
            G(i,j) = ( J(i,j,1) +J(i,j,2)+ J(i,j,3) )/3 ;
            
  
     end
end
figure,imshow(G)

%%
%  Utilize o programa “IrfanView” para obter as seguintes informações das imagens
% “Lenna_gray.jpg, Lenna_rgb.jpg, Baboo_rgb.bmp e Baboo_gray.bmp”:
% Resolução da imagem = Profundidade do pixel =
% Resolução espacial = Tamanho original da cena =
% Teoricamente, qual seriam os tamanhos dos arquivos, em kBytes, para armazenar essa
% imagem? Qual o tamanho real? Por que a diferença entre os diferentes formatos? 





Terceira = imread('Baboo_gray.bmp');


% imagem Baboo_rgb.bmp de 90 graus e salve-as nos formatos BMP,
% JPEG, TIFF e GIF. Use o comando imrotate (veja help). Preencha uma tabela abaixo
% informando todos os valores obtidos

segunda  = imread('Baboo_rgb.bmp');
figure,imshow(segunda)

segunda = imrotate(segunda,90);
% figure,imshow(seg)



%%

primeira = imread('Lenna_gray.jpg');


[linha,coluna]=size(primeira);
espelho=zeros(linha,coluna);

c=1;
 for j= (linha):-1:1
   
        espelho(:,c)= primeira(:,j);
        c=c+1; 
        
 end
 espelho=uint8(espelho);
 figure,imshow(espelho)
 
figure, subplot(2,2,1),imshow(primeira)
subplot(2,2,2), imshow(espelho)

%% Funçao rotaçao !
close all 
clear all 
clc

% expplicaçao esta no caderno !!

img = imread('Lenna_gray.jpg');
ang =45;


[lin,col] = size(img);
nimg = zeros(lin , col);
% Cria matriz de rotação (cosd e sind é em graus, cos e sin é em radiano)
trans = [cosd(ang) -sind(ang) 0;
    sind(ang) cosd(ang) 0;
    0 0 1];
for i=1:lin
    for j=1:col
        % round serve para arredondar
            nponto = round(trans * [i , j ,1]');
            if nponto(1) > 0 & nponto(1) <= lin & nponto(2) > 0 & nponto(2) <= col
                nimg (nponto(1) , nponto(2)) = img(i , j);
            end
    end
end
nimg=uint8(nimg);
 figure,imshow(nimg)


%% Translaçao

img = imread('Lenna_gray.jpg');

dx= 256;
dy=1;

[lin,col] = size(img);
nimg = zeros(lin , col);
% Cria matriz de translação
trans = [1 0 dx;
 0 1 dy;
 0 0 1];
for i=1:lin
 for j=1:col
 nponto = round(trans * [i ; j ;1]);
 if nponto(1) > 0 && nponto(1) <= lin && nponto(2) > 0 && nponto(2) <= col
 nimg (nponto(1) , nponto(2)) = img(i , j);
 end
 end
end
nimg=uint8(nimg);
 figure,imshow(nimg)

%% Escala

img = imread('Lenna_gray.jpg');
sx= 20;
sy= 30;
[lin,col] = size(img);
nimg = zeros(sx*lin , sy*col);
% Cria matriz de escala
trans = [sx 0 0;
    0 sy 0;
    0 0 1];
for i=1:lin
    for j=1:col
        nponto = round(trans * [i ; j ;1]);
        if nponto(1) > 0 && nponto(1) <= sx*lin &&  nponto(2) > 0 && nponto(2) <= sy*col
            nimg (nponto(1) , nponto(2)) = img(i , j);
        end
    end
end
nimg=uint8(nimg);


%%
img = imread('Lenna_gray.jpg');

ang =45;

[lin,col] = size(img);
lin2 = round(sqrt(lin.^2 + col.^2));
col2 = lin2;
nimg = zeros(lin2,col2);
rot = [cosd(ang) -sind(ang) 0;
    sind(ang) cosd(ang) 0;
    0 0 1];
Trans = [1 0 floor(lin2/2);
    0 1 floor((col2)/2);
    0 0 1 ];
Trans_inv = [1 0 -floor(lin/2);
    0 1 -floor(col/2);
    0 0 1 ];
for i=1:lin
    for j=1:col
        nponto = round(Trans*rot*Trans_inv*[i ; j ;1]);
        if nponto(1) > 0 && nponto(1) <= lin2 && nponto(2) > 0 && nponto(2) <= col2
                nimg(nponto(1) , nponto(2)) = img(i,j);
        end
    end
end
nimg = uint8(nimg);
figure,imshow(nimg)
% tratamento na imagem

menorvalor = 100
maiorvalor = 255

nimg = double(nimg);
nimg = nimg-menorvalor;
nimg = (255*nimg)/maiorvalor;
nimg = uint8(nimg);
figure,imshow(nimg)
% histograma  
figure,imhist(nimg)
 
 
%% Questao 4: Quantizaçao 
% Quantizar tem a  ver com as cores os valores dos pixels 
% por isso que para quantizar usamos o bitshift , que altera os 
% valores dos bit , e por ultimo fazemos um ajuste na distribuiçao dos tons



img = imread('Lenna_gray.jpg');
nbitsShift = 5;
nimg = bitshift(img, -nbitsShift);
nimg = bitshift(nimg, nbitsShift);
figure,imshow(nimg)
figure,imhist(nimg)

% a funçao para justar as cores, 
% ela pega o menor valor e joga para zero , 
% e o maior valor joga para 255 
% e o restante segue essa proporçao;

nimg = double(img);
mmin= min(nimg(:));
nimg= nimg-mmin;
mmax= max(nimg(:));
nimg= (255 * nimg) / mmax; 
figure,imshow(uint8(nimg))

% 4) Implemente uma função que permita quantizar uma imagem a “n” quantidade de cores, onde
% “n” não é necessariamente uma potência de 2. Modifique a função Mapping(), de forma tal
% que é o usuário quem determina qual é o menor e o maior valor dentro na nova escala.

menorvalor = 2
maiorvalor = 200

nimg = double(img);
nimg = nimg-menorvalor;
nimg = (255*nimg)/maiorvalor;
figure,imshow(uint8(nimg))


%% implementar um histograma:

img = imread('Lenna_gray.jpg');
[linha,coluna]=size(img);
vetor_cor= zeros(255);

for i=1:1:linha
    for j=1:coluna
        
     a=img(i,j);
     vetor_cor(a)= vetor_cor(a)+1;
     a=0;  
        
        
    end
end

barra_de_cor = linspace(1,255,100);
figure,plot(vetor_cor,'b')
barra= uint8(barra_de_cor);











