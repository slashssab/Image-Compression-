% function [comp,centers,p]=coder
clear all;
close all;

imTiger=imread('Tiger.jpg');
N=8; %rozmiar bloczków
YCBCR = rgb2ycbcr(imTiger);
[height, width, colour]=size(YCBCR);

A=[16  11  10  16   24   40   51   61;
12  12  14  19   26   58   60   55;
14  13  16  24   40   57   69   56;
14  17  22  29   51   87   80   62;
18  22  37  56   68   109  103   77;
24  35  55  64   81   104  113   92;
49  64  78  87  103  121  120  101;
72  92  95  98  112  100  103   99];
A=A(1:N,1:N);
A = A/1;

B = repmat(A,height/N,width/N);
afDct=zeros(512,1024,3); %Inicjalizacja obrazu transformaty cosunusowej
K=zeros(512,1024,3); %Inicjalizacja obrazu odwrotnej transformaty cosunusowej

for i=0:height/N-1
   for j=0:width/N-1
       for c=1:colour
            afDct(1+N*i:N+N*i,1+N*j:N+N*j,c)=dct2(YCBCR(1+N*i:N+N*i,1+N*j:N+N*j,c));
       end
   end
end
afDct=afDct./B;


[huffmanarray, dictarray]=CoderHuffman(height, width, colour,N,afDct);
b=DecoderHuffman(dictarray, huffmanarray,height, width, colour,N);


b=b.*B;
for i=0:height/N-1
   for j=0:width/N-1
       for c=1:colour
            K(1+N*i:N+N*i,1+N*j:N+N*j, c)=idct2(b(1+N*i:N+N*i,1+N*j:N+N*j, c));
       end
   end
end


k=ycbcr2rgb(K/255);
figure
imshow(double(imTiger)/255-k);
figure
imshow(k);

blad=mean(mean(mean(double(imTiger)/255-k))).^2;
imwrite(ycbcr2rgb(K/255),'Tigerr.jpg');
dlmwrite('myFile.jmw',huffmanarray)
