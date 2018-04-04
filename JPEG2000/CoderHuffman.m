function [huffmanarray, dictarray]=CoderHuffman(height, width, colour,N,afDct)

huffmanarray=zeros(24577, 101);
dictarray=zeros(24577,N^2,2);

%proawd, wart oraz kod huffmana 

xd=1;
for i=0:height/N-1
   for j=0:width/N-1
       for c=1:colour
            sig =zigzag(round(afDct(1+N*i:N+N*i,1+N*j:N+N*j,c),0));
            [pop, p]=prob(sig) ;
            dict = huffmandict(pop,p);
             h= huffmanenco(sig,dict);     
             for v=1:length(p)
                    dictarray(xd,v,1)=p(v); 
                    dictarray(xd,v,2)=pop(v); 
             end
             for v=1:length(h)
                    huffmanarray(xd,v)=h(v); 
             end
             dictarray(xd, length(p) + 1, 1)=-1; 
             dictarray(xd, length(p) + 1, 2)=-1; 
             huffmanarray(xd, length(h) + 1)=-1;
              
             xd=xd+1;
       end
   end
end

end