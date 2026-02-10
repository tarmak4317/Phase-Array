A = 5;
wavelength = 20;
inter_space = 2000;
phase = [0 0 0 0 0];
arr = zeros(8000, 8000);
offset = 16000;
for i = 1:8000
    for j = 1:8000
        d1 = sqrt(((i - 1 + offset)/1000)^2 + ((j - 1 )/1000)^2) + phase(1);
        d2 = sqrt(((i - 1 + offset)/1000)^2 + ((j - 1 - inter_space)/1000)^2) + phase(2);
        d3 = sqrt(((i - 1 + offset)/1000)^2 + ((j - 1 - 2*inter_space)/1000)^2) + phase(3);
        d4 = sqrt(((i - 1 + offset)/1000)^2 + ((j - 1 - 3*inter_space)/1000)^2) + phase(4);
        d5 = sqrt(((i - 1 + offset)/1000)^2 + ((j - 1 - 4*inter_space)/1000)^2) + phase(5);
        A1 = A * mod(floor(d1/wavelength),2);
        A2 = A * mod(floor(d2/wavelength),2);
        A3 = A * mod(floor(d3/wavelength),2);
        A4 = A * mod(floor(d4/wavelength),2);
        A5 = A * mod(floor(d5/wavelength),2);
        arr(i, j) = (A1 + A2 + A3 + A4 + A5)^2;
    end
end
imagesc(arr);
colorbar;
axis equal;
title('Interference Pattern from 5 Sources');
xlabel('X');
ylabel('Y');
