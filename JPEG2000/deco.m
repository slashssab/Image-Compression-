function dsig=deco(comp,centers,p)
dict = huffmandict(centers,p);
dsig = huffmandeco(comp,dict);

