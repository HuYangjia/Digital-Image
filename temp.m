image = imread("/home/ubuntu/Downloads/matlab/lab4/fig/Girl.bmp");

% 添加高斯噪声 , mu=0, sigma=0.1
image_noise = imnoise(image, 'gaussian', 0, 0.03); 
image_noise2 = imnoise(image, 'gaussian', 0, 0.1);
image_noise3 = imnoise(image, 'gaussian', 0, 0.5);

fft = fftshift(fft2(image));
fft_noise = fftshift(fft2(image_noise));
fft_noise2 = fftshift(fft2(image_noise2));
fft_noise3 = fftshift(fft2(image_noise3));

figure;
subplot(2, 4, 1); imshow(image); title('原始图像');
subplot(2, 4, 2); imshow(image_noise); title('高斯噪声1');
subplot(2, 4, 3); imshow(image_noise2); title('高斯噪声2');
subplot(2, 4, 4); imshow(image_noise3); title('高斯噪声3');
subplot(2, 4, 5); imshow(log(abs(fft)+1), []); title('FFT频谱');
subplot(2, 4, 6); imshow(log(abs(fft_noise)+1), []); title('FFT频谱移位1');
subplot(2, 4, 7); imshow(log(abs(fft_noise2)+1), []); title('FFT频谱移位2');
subplot(2, 4, 8); imshow(log(abs(fft_noise3)+1), []); title('FFT频谱移位3');
 