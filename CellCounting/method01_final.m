

% loading photo

img_original = imread('input1.jpg');
img_gray = rgb2gray(img_original);

 %figure, imshow(img_gray); title('imagem em escala de cinza');
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
 figure, imshow(nimg);title('depois do Hist adjust');
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

 %figure, imshow(nimg);title('After Thresing hold')
%
% ####  Morphological operations ### %%
se = strel('square',3)
se2 = strel('line',9,90);
se3 = strel('line',9,180) ;
nimg = imopen(nimg,se2);
nimg = imopen(nimg,se3);
% figure,imshow(nimg);title('Open & erode ');
%%

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


%% Binarizing and Adjusting 

level = multithresh(saida,4);
BW = imbinarize(saida,double(level(2))/255);
%figure, imshow(BW);title('imagem binarizada');

% Remove  pixels smaller or equal a 10
BW = ~bwareaopen(~BW, 10);
%figure, imshow(BW); title('bwareaopen');



%% Watershed Segmenation :

D = bwdist(~BW);
%figure,imshow(D,[],'InitialMagnification','fit');title('Distance transform of ~bw')

L = watershed(D,8);
L(~BW) = 0;
[img_Labeled num] = bwlabel(L);

%figure, imshow(uint8(L));title('watershed');

%### Water shed view in rgb scale: ###%
    % rgb = label2rgb(L,'jet',[.5 .5 .5]);
    % figure
    % imshow(rgb,'InitialMagnification','fit')
    % title('Watershed transform of D')



    %% ############### Final Part ##################3##%% :
% In this part I used Bwboundaries in order to trace regions where
% the spores are, FutherMore I appended aux variable to countig the numeber of spores,
% So, I was able to display either the original image and the sproe regions
% it all together.
    
figure, imshow(img_original); hold on;
colors=['b' 'g' 'r' 'c' 'm' 'y'];
[B,L,N,A] = bwboundaries(uint8(img_Labeled), 'noholes');
aux =1;

for k=1:length(B),
    
      if size(B{k},1)> 15 & size(B{k},1) < 600
      boundary = B{k};
      cidx = mod(k,length(colors))+1;
      plot(boundary(:,2), boundary(:,1),...
           colors(cidx),'LineWidth',0.5);

      %randomize text position for better visibility
      rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
      col = boundary(rndRow,2); row = boundary(rndRow,1);
      
      % Uncoment this part in order to plot numbers of counting 
      % attach to boundaries regions :
          %   h = text(col+1, row-1, num2str(aux));
          %   set(h,'Color',colors(cidx),'FontSize',14,'FontWeight','bold');
      
      % this variable aux is in charge for boundaries/spores counting:
      aux = aux+1;
      end
  
 mytitle =  strcat('WaterShed Segmantation: Spores = ', num2str(aux));
end
title(mytitle ,'FontSize', 14,'FontWeight','bold','Color', 'r')

