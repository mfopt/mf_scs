function l = getConeDims(K)
l = K.f + K.l;
for i=1:length(K.q)
    l = l + K.q(i);
end
for i=1:length(K.s)
    l = l + (K.s(i))^2;
end
l = l + K.ep*3;
l = l + K.ed*3;
end