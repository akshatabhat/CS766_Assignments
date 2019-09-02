function mask = computeMask(img_cell)
mask = zeros(size(cell2mat(img_cell(1))));
for i=1:size(img_cell,1)
    img = cell2mat(img_cell(i));
    mask = mask|(img>0);
end
