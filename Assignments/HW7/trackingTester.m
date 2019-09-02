function trackingTester(data_params, tracking_params)
img1 = imread(fullfile(data_params.data_dir,...
    data_params.genFname(data_params.frame_ids(1))));
object_img = img1(tracking_params.rect(2):tracking_params.rect(2)+tracking_params.rect(4)-1,tracking_params.rect(1):tracking_params.rect(1)+tracking_params.rect(3)-1,:);
[X,cmap] = rgb2ind(object_img,tracking_params.bin_n);
X_col = im2col(X, [tracking_params.rect(4),tracking_params.rect(3)]);
histogram_src = histc(X_col+1, 1:tracking_params.bin_n);
image_with_bbox = drawBox(img1, tracking_params.rect, [255, 0, 0], 3);
rect_src = tracking_params.rect;
imwrite(image_with_bbox, fullfile(data_params.out_dir,data_params.genFname(data_params.frame_ids(1))))
for f=data_params.frame_ids(2:end)
    img = imread(fullfile(data_params.data_dir,...
    data_params.genFname(data_params.frame_ids(f))));
    [rect_dest, histogram_dst] = search(img, rect_src, tracking_params, cmap, histogram_src);
    image_with_bbox = drawBox(img, rect_dest, [255, 0, 0], 3);
    imwrite(image_with_bbox, fullfile(data_params.out_dir,data_params.genFname(data_params.frame_ids(f))));
    histogram_src = histogram_dst;
    rect_src = rect_dest;
end

function [max_rect, max_match_hist]=search(img2, src_rect, tracking_params, cmap, histogram_1)
x = src_rect(1);
y = src_rect(2);
width = src_rect(3);
height = src_rect(4);

x1 = max(1, x-tracking_params.search_half_window_size);
x2 = min(size(img2,1)-width,x+tracking_params.search_half_window_size);
y1 = max(1, y-tracking_params.search_half_window_size);
y2 = min(size(img2,1)-height,y+tracking_params.search_half_window_size);

max_match = 100000;
for i=x1:x2
    for j=y1:y2
        object_img = img2(j:j+height-1,i:i+width-1,:);
        X = rgb2ind(object_img, cmap);
        X_col = im2col(X, [height,width]);
        histogram_2 = histc(X_col+1, 1:tracking_params.bin_n);
        dist = norm(histogram_1-histogram_2);
        if dist < max_match
            max_rect = [i j width height];
            max_match_hist = histogram_2;
            max_match = dist;
        end
    end
end