

clear all 
close all

B= imread('cameraman.tif');
figure,imshow(B)


%% Importa forest.tif 
L=imread('forest.tif');
figure,imshow(L)
% com o importe do map o matlab fz referencia ao mapa de cor e quando
% exibido a imagem aparece coloria
[L,map]=imread('forest.tif');
figure,imshow(L,map)


%%
J=imread('board.tif');
figure,imshow(J)

%tranformar essa igamem colorida em nivel de cinsa;

R = J(:,:,1);
G = J(:,:,2);
B = J(:,:,3);
%indices de bayer
a = 0.299;
b = 0.587;
c = 0.114;
% filtro de bayer
Y = a*R + 0*G + 0*B;
figure,imshow(Y)

% transofrmando em vermelho a imagem 
% para isso é preciso zerar a 2 e terceira dimensao, correposndente ao G&B
J(:,:,2)=0;
J(:,:,3)=0;
figure,imshow(J)

F = (R+G+B)/3;
figure,imshow(F)

%% Pegando o negativo da imagem 
%para fazer isso é preciso pegaro os valores proximo a 
% 0 --> transformar em --> 255
% 255 --> transformar em --->0;

imagem = imread('cameraman.tif');

% a conversao para double é necessaria semrpe que for manipular os valores
% da imagem.

negativa_imagem = uint8(-1*(double(imagem)-255));
figure,imshow(negativa_imagem)


%% 

C= imread('lenna_rgb.jpg');
figure, imshow(C)

 figure, subplot(2,2,1); imshow(C(:,:,1));title('escala de red')

 subplot(2,2,2); imshow(C(:,:,2));title('escala de green')

 subplot(2,1,2);  imshow(C(:,:,3));title('escala de blue')
 
 
% deixar mais visivel agr 
 
%criando tres matrizes de tres dimensoes com zeros em todas
b_R = uint8(zeros(size(C)));
b_G = uint8(zeros(size(C)));
b_B = uint8(zeros(size(C)));

% alocando apenas os matrizes correspondentes em cada 
b_R(:,:,1) = C(:,:,1);
b_G(:,:,2) = C(:,:,2);
b_B(:,:,3) = C(:,:,3);
 
 

figure, subplot(2,2,1); imshow(b_R);title('escala de red')

subplot(2,2,2); imshow(b_G);title('escala de green')

subplot(2,1,2);  imshow(b_B);title('escala de blue')
 

 
 %% Duplicando os valores de m
 
 m=[5 9;15 3];
 [l,c]=size(m);
 X=zeros(l*2,c*2);
 d=1;
 
 for i=1:2:3
     %  B=repmat(m(i),2);

     for j=1:2:3
         B=repmat(m(d),2);
         X(j:j+1 , i:i+1)= B;
         d=d+1;
         
         
     end
     
 end
 
 
 %% Pratica 01 %%%
 %
 % Pratica 01 %%%
 % Pratica 01 %%%
 % Pratica 01 %%%
 
 
 
%  help colormap
%  A=imread('trees.tif');
%  imshow(A)
%  whos
%  help imread
%  help imshow // Veja os exemplos neste help
%  [A,map]=imread('trees.tif');
%  figure, imshow(A,map);
%  whos
%  imfinfo('trees.tif') 
 
 
 
B=imread('cameraman.tif');
C=filter2([1 2;-1 -2],B);
figure,imshow(B);
figure,imshow(C);

D= uint8(C);
figure,imshow(D)
whos
figure,imshow(uint8(C));
min(B(:))
max(B(:))
min(C(:))
max(C(:))
figure,imshow(C,[min(C(:)) max(C(:))]);
figure,imshow(C,[]) 
 
 
 
%% Imagem binaria

BW1=zeros(20,20);
BW1(2:2:18 ,2:2:18 )=1; %// O que esse commando faz? Analise esta variável...
imshow(BW1); figure, imshow(BW1, 'notruesize'); 
% bw1 e do tipo double logo o matlab entende que 
% 0 = preto , 1 = branco



BW2 = uint8(BW1);
% quando tranformamos em  uint8 o matlab passa a entender 
% as cores entre 0 e 255 logo 0=preto 1= preto ... 255= branco;
BW2(2:2:18 ,2:2:18 )=225;
% substituindo 1 por 255 , vamo exibir uma imagem igual a anterior
figure, imshow(BW2);



%% Curiosidades: ocultar imagem (comando bitshift) – utilizar as imagens Lenna e image
% Pepper com deslocamento de 5 bits. 

 
 B=imread('lenna_rgb.jpg');
 figure, imshow(B) 
 
 T=bitshift(B,1);
 figure, imshow(T)
 
 
 
% Basicamente o bitshift  esta movendo em duas 
% posicoes ' bits' os balores de B; observe o resultado abaixo 
% essa açaop muda as cores


% B =
% { 11100010
%   11100001
%   11100001
%   11100011 }
%  
% T = dec2bin(bitshift(B(1:2,1:2),2));
% 
% T =  
% { 10001000
%   10000100
%   10000100
%   10001100 }
%



 
 
 
