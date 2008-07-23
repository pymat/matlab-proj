[X, labels,t] = generate_data('swiss', 2000, 0.05);
scatter3(X(:,1), X(:,2), X(:,3), 5, labels); drawnow
d = intrinsic_dim(X, 'MLE');
disp(['Intrinsic dimensionality of data: ' num2str(d)]);
