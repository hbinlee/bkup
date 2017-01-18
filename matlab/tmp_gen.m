rng default; % For reproducibility
X = [randn(3200,2)*0.7+ones(3200,2);
    randn(800,2)*0.2+ones(800,2)*1.5];

figure;
plot(X(:,1),X(:,2),'.');