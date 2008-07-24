[X, labels] = generate_data('swiss', 2000, 0.05);
d = round(intrinsic_dim(X));
Y1 = compute_mapping(X, 'LLE');
Y2 = compute_mapping(X, 'LLE', d, 7);
Y3 = compute_mapping(X, 'Laplacian', d, 7, 'JDQR');
Y4 = compute_mapping(X, 'LTSA', d, 7);
Y5 = compute_mapping(X, 'CCA', d, 'Matlab');
subplot(3, 2, 1), scatter3(X(:,1), X(:,2), X(:,3), 5, labels); title('Original')
subplot(3, 2, 2), scatter(Y1(:,1), Y1(:,2), 5, labels); title('LLE')
subplot(3, 2, 3), scatter(Y2(:,1), Y2(:,2), 5, labels); title('LLE d 7')
subplot(3, 2, 4), scatter(Y3(:,1), Y3(:,2), 5, labels); title('Laplacian')
subplot(3, 2, 5), scatter(Y4(:,1), Y4(:,2), 5, labels); title('LTSA')
subplot(3, 2, 6), scatter(Y5(:,1), Y5(:,2), 5, labels); title('CCA')
