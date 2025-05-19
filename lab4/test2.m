image1 = imread("/home/ubuntu/Downloads/matlab/lab4/fig/Rect1.bmp");
image2 = imread("/home/ubuntu/Downloads/matlab/lab4/fig/Rect2.bmp");

% 三个反变换

fft_1 = fft2(image1);
fft_2 = fft2(image2);

% 幅度反变换
IF1_abs = uint8(ifft2(abs(fft_1)));
IF2_abs = uint8(ifft2(abs(fft_2)));

% 相位反变换
m = 10000; % 乘以一个常数,实验发现，不然太小了
phase1 = angle(fft_1);
phase2 = angle(fft_2);
IF1_angle = uint8(abs(ifft2(m*exp(1i*phase1))));
IF2_angle = uint8(abs(ifft2(m*exp(1i*phase2))));

% 共轭反变换
conjF1 = conj(fft_1);
conjF2 = conj(fft_2);
IF1_conj = ifft2(conjF1);
IF2_conj = ifft2(conjF2);

subplot(2, 4, 1); imshow(image1); title('rect 1');
subplot(2, 4, 2); imshow(IF1_abs); title('Magnitude Inverse 1');
subplot(2, 4, 3); imshow(IF1_angle); title('Phase Inverse 1');
subplot(2, 4, 4); imshow(IF1_conj); title('Conjugate Inverse 1');

subplot(2, 4, 5); imshow(image2, []); title('rect 2');
subplot(2, 4, 6); imshow(IF2_abs, []); title('Magnitude Inverse 2');
subplot(2, 4, 7); imshow(IF2_angle); title('Phase Inverse 2');
subplot(2, 4, 8); imshow(IF2_conj, []); title('Conjugate Inverse 2');

% 保存
filename = '/home/ubuntu/Downloads/matlab/lab4/fig/';
saveas(gcf, [filename 'reverse.png']);