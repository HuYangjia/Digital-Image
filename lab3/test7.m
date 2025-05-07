% 多种算子做边缘检测

filename = '/home/ubuntu/Downloads/matlab/lab3/fig/';
lena = imread([filename 'lena.bmp']);
blood = imread([filename 'blood.bmp']);

% Roberts算子
lena_roberts = edge(lena, 'Roberts');
blood_roberts = edge(blood, 'Roberts');

% Sobel算子
lena_sobel = edge(lena, 'Sobel');
blood_sobel = edge(blood, 'Sobel');

% Prewitt算子
lena_prewitt = edge(lena, 'Prewitt');
blood_prewitt = edge(blood, 'Prewitt');

% 4邻域拉普拉斯算子
lena_laplacian1 = edge(lena, 'log');
blood_laplacian1 = edge(blood, 'log');
% 8邻域拉普拉斯算子
lena_laplacian2 = edge(lena, 'log', 0, 1);
blood_laplacian2 = edge(blood, 'log', 0, 1);

% Canny算子
lena_canny = edge(lena, 'Canny');
blood_canny = edge(blood, 'Canny');

% 显示图像
figure;
subplot(2, 7, 1); imshow(lena); title('lena');
subplot(2, 7, 2); imshow(lena_roberts); title('Roberts');
subplot(2, 7, 3); imshow(lena_sobel); title('Sobel');
subplot(2, 7, 4); imshow(lena_prewitt); title('Prewitt');
subplot(2, 7, 5); imshow(lena_laplacian1); title('Laplacian4');
subplot(2, 7, 6); imshow(lena_laplacian2); title('Laplacian8');
subplot(2, 7, 7); imshow(lena_canny); title('Canny');
subplot(2, 7, 8); imshow(blood); title('blood');
subplot(2, 7, 9); imshow(blood_roberts); title('Roberts');
subplot(2, 7, 10); imshow(blood_sobel); title('Sobel');
subplot(2, 7, 11); imshow(blood_prewitt); title('Prewitt');
subplot(2, 7, 12); imshow(blood_laplacian1); title('Laplacian4');
subplot(2, 7, 13); imshow(blood_laplacian2); title('Laplacian8');
subplot(2, 7, 14); imshow(blood_canny); title('Canny');

% 调整子图间距
set(gcf, 'Position', get(0,'Screensize')); % 使图形窗口最大化
saveas(gcf, [filename 'subplot_edge.png']);