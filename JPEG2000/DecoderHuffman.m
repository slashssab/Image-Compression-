function imToDct2=DecoderHuffman(dictarray, huffmanarray,height, width, colour,N)
xd=1;
imToDct2=zeros(512,1024,3);

for i=0:height/N-1
   for j=0:width/N-1
       for c=1:colour
            dict = huffmandict( dictarray(xd,1:checkindex(dictarray(xd,:,1)),2), dictarray(xd,1:checkindex(dictarray(xd,:,1)),1));
            dsig = huffmandeco(huffmanarray(xd,1:checkindex(huffmanarray(xd,:))),dict);
            imToDct2(1+N*i:N+N*i,1+N*j:N+N*j,c)=invzigzag(dsig,N,N);
            xd=xd+1;
       end
   end
end
end