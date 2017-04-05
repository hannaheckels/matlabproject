function [avg med mod vari stdev mini maxi count stdev2 ] = mystat( X )
%UNTITLED3 Summary of this function goes here
%   Name: Hannah Eckels
%   Class: ENGR 112-522
%   Date: 2/02/2017
%   Assignment: ICA
avg=mean(X);
med=median(X);
mod=mode(X);
vari=var(X);
stdev=std(X);
mini=min(X);
maxi=max(X);
count=length(X);
for i = 1:count
    count = count + 1;
end
if count > 30
    stdev = std(X, 1);
    stdev2 = ('Population Stadard Deviation');
else 
     stdev = std(X, 1);
    stdev2 = ('Population Stadard Deviation');
end



end

