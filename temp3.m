image = imread("/home/ubuntu/Downloads/matlab/lab4/fig/Girl.bmp");

fft = fft2(image)
fft_ = conj(fft)

result = ifft2(fft_)

figure;
subplot(1,2,1);imshow(image); title('rect 1');
subplot(1,2,2);imshow(result,[]); title('rect 2');