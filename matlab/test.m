f=@(x)(0);
for i=1:1000000
    f=@(x)(f(x)+i*x);
end
tic;
f(1)
toc;