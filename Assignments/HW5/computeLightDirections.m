function light_dirs_5x3 = computeLightDirections(center, radius, img_cell)
light_dirs_5x3 = zeros(5, 3);
for i=1:size(img_cell, 1)
    img = cell2mat(img_cell(i));
    [max_val, idx] = max(img(:));
    [y, x] = ind2sub(size(img), idx);
    N = calculate_normal(x, y, center, radius, max_val);
    light_dirs_5x3(i,:) = N;
end
function N = calculate_normal(x, y, center, radius, max_val)
z = sqrt(radius^2 - (x-center(1))^2-(y-center(2))^2);
p = (x-center(1));
q = (y-center(2));
scale = double(max_val)/ (sqrt(p^2 + q^2 + z^2));
N = [p q z] * scale;