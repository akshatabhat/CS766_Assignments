function refocusApp(rgb_stack, depth_map)
y_size = size(rgb_stack,1);
x_size = size(rgb_stack,2);
imshow(uint8(rgb_stack(:,:,1:3)));
while true
    % Choose a point
    [xs,ys] = ginput(1);
    if xs < 0 || xs > x_size ||ys < 0 || ys > y_size
        break
    end
    image_idx = depth_map(round(ys), round(xs));
    start_idx = (image_idx-1)*3+1;
    imshow(uint8(rgb_stack(:,:,start_idx:start_idx+2)));
end
