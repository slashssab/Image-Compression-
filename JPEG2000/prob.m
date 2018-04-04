function [pop, prob]=prob(list)


pop=unique(list);
prob=zeros(1,size(pop,2));
for i=1:size(pop,2)
    prob(i)=sum(list==pop(i))/size(list,2);
end

