A = 5;
w = 200;
v = 500;
inter_space = 200;
grid_size = 8000;
del = deg2rad([0 15 30 45 60]); % example phase shifts

% Create grid
[x, y] = meshgrid(0:grid_size-1, 0:grid_size-1);  % x and y are 800x800 matrices
x = x / 100;  % convert to physical units
y = y / 100;

% Create source positions (at bottom of screen)
y_offsets = (0:4) * inter_space / 100;  % spacing in meters

% Initialize result array
arr = zeros(size(x));

% Sum fields from all 5 sources
for k = 1:5
    t = sqrt(x.^2 + (y - y_offsets(k)).^2) / v;
    A_k = A * sin(w * t + del(k)) .* exp(-t);
    arr = arr + A_k;
end

% Intensity is square of total amplitude
arr = arr.^2;

% Plot
imagesc(arr);
colorbar;
axis equal;
title('Vectorized Interference Pattern (5 Sources)');
xlabel('X');
ylabel('Y');
