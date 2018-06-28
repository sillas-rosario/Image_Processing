



% loading photo

img_original = imread('input1.jpg');
img_gray = rgb2gray(img_original);

% figure, imshow(img); title('imagem em escala de cinza');
% figure, imhist(img); title( 'Histograma da Imagem em Escala de Cinza');


%%
%  Histograma ajuste
[lin,col] = size(img_gray);
% Número total de pixels
N = lin*col;
hist = imhist(img_gray)/N;
histAcumNorm = cumsum(hist);
nimg = histAcumNorm(img_gray+1);
nimg = uint8(nimg*255);
% figure, imshow(nimg);title('depois do Hist adjust');
nimg1 = nimg;
% figure, imhist(nimg);title('hist ajustado');

%%% Aplicaçao do threshold
h = imhist(nimg, 256);
p = h / sum(h);
omega = cumsum(p);
mu = cumsum(p .* [1:256]');
muT = mu(end);
sigma_b = (muT .* omega - mu).^2 ./ (omega .* (1 -omega));
m = max(sigma_b);
T = mean(find(sigma_b == m));

[lin,col] = size(img_gray);
nimg = zeros(lin,col);
ind = img_gray<=T;
nimg(ind) = 255;

% figure, imshow(nimg)
% title('After Thresing hold')

% ####  Morphological operations ### %%
se = strel('square',3)
se2 = strel('line',9,90);
se3 = strel('line',9,180) ;
nimg = imopen(nimg,se2);
nimg = imopen(nimg,se3);
% figure,imshow(nimg);title('Open & erode ');


% ## First Segmentation ## %%
[label , num ] = bwlabel(nimg,8);
[lin,col] = size(nimg);
saida = uint8(zeros(lin,col));

for i = 1  : num
    [row, col] = find(label == i);
 
      % Building a new Matrix:
        for j = 1 :size(row,1)
            
           x = row(j,1) ;
           y = col(j,1);
       
            saida(x,y) = img_gray(x,y);
            
        end
        
        saida(min(row): min(row) +2 ,min(col): y ) = 150;
        saida(max(row): max(row) +2 ,min(col): y  ) = 150;
        
        saida( min(row): max(row) , min(col) : min(col) + 2 ) = 150;
        saida( min(row): max(row) , y-2 : y       ) = 150;
       

end

%figure, imshow(saida); title( 'Imagem without Neu Bauer Grid ');
%%


% I_eq = adapthisteq(saida);
% figure,imshow(I_eq); title(' Imagem com histograma adaptado')
% %
% I_eq =saida;
% [h,x] = imhist(I_eq);
% [M,I] = max(h(10:170),[],1);
% ax = (I-10)/255; ay = (I+10)/255;
% 
% tol = [ax ay];
% stretch = imadjust(I_eq,stretchlim(I_eq,tol),[]);
% figure, imshow(stretch); title('imagem alongada')
% figure, imhist(stretch); title('histograma da imagem stretched');

n =4;
level = multithresh(saida,n);
thre = sum(double(level)/n)

nJ = imbinarize(saida,thre/255);
figure, imshow(nJ);

%
% bw4 = ~bwareaopen(~nJ, 50);
% figure, imshow(bw4); title('bwareaopen');

BW_eroded = imerode(nJ,ones(2,2));
%figure, imshow(BW_eroded)


%
figure, imshow(img_original); hold on;
colors=['b' 'g' 'r' 'c' 'm' 'y'];
[B,L,N,A] = bwboundaries(BW_eroded, 'holes');
aux =1;

for k=1:length(B),
    
      if size(B{k},1)> 15 & size(B{k},1) < 400
      boundary = B{k};
      cidx = mod(k,length(colors))+1;
      plot(boundary(:,2), boundary(:,1),...
           colors(cidx),'LineWidth',2);

      %randomize text position for better visibility
      rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
      col = boundary(rndRow,2); row = boundary(rndRow,1);
      % label circle
    %   h = text(col+1, row-1, num2str(aux));
    %   set(h,'Color',colors(cidx),'FontSize',14,'FontWeight','bold');
      aux = aux+1;


  end
 mytitle =  strcat(' Quantidade  de Esporos é : ', num2str(aux));
end
title(mytitle ,'FontSize', 14,'FontWeight','bold','Color', 'r')



