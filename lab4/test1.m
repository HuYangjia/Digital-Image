image1 = imread("/home/ubuntu/Downloads/matlab/lab4/fig/Rect1.bmp");
image2 = imread("/home/ubuntu/Downloads/matlab/lab4/fig/Rect2.bmp");

% 初步FFT2
fft_1 = fft2(image1);
fft_2 = fft2(image2);

% 获得频谱
fft_1_fre = abs(fft_1);
fft_2_fre = abs(fft_2);

% 对幅度做变换
fft_1_shift = log(abs(fftshift(fft_1))+1);
fft_2_shift = log(abs(fftshift(fft_2))+1);


% 查阅发现，变换后，范围不在于0-255，所以添加[]参数
subplot(2, 4, 1); imshow(image1); title('原始图像1');
subplot(2, 4, 2); imshow(real(fft_1)) ; title('direct\_FFT1');
subplot(2, 4, 3); imshow(fft_1_fre); title('FFT1频谱');
subplot(2, 4, 4); imshow(fft_1_shift, []); title('FFT1频谱移位');

subplot(2, 4, 5); imshow(image2, []); title('原始图像2');
subplot(2, 4, 6); imshow(real(fft_2)) ; title('direct\_FFT2');
subplot(2, 4, 7); imshow(fft_2_fre); title('FFT2频谱');
subplot(2, 4, 8); imshow(fft_2_shift, []); title('FFT2频谱移位');

% 保存
filename = '/home/ubuntu/Downloads/matlab/lab4/fig/';
saveas(gcf, [filename 'FFT.png']);