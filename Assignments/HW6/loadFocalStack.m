function [rgb_stack, gray_stack] = loadFocalStack(focal_stack_dir)
stack_dir = sprintf(focal_stack_dir);
cd(stack_dir)
Files = dir( "*.jpg");
num_images = length(Files);
for i=1:num_images
    image = imread(sprintf('frame%d.jpg', i)); 
    if i==1
        image_size = size(image);
        rgb_stack = zeros(image_size(1), image_size(2), 3*num_images);
        gray_stack = zeros(image_size(1), image_size(2), num_images);
    end
    start_idx = (i-1)*3+1;
    rgb_stack(:,:,start_idx:start_idx+2) = image;
    gray_stack(:,:,i) = rgb2gray(image);
end
cd('../')