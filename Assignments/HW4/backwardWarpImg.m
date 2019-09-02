function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)

% Creating grid of coordinates in destination image.
[X, Y]=meshgrid(1:dest_canvas_width_height(1),1:dest_canvas_width_height(2));
points = [X(:), Y(:)];
dest_pts = [points ones(size(points,1),1)];

% Applying inverse homography on destination image to find corresponding
% coordinates in src image
src_pts = dest_pts*resultToSrc_H;
Uq = src_pts(:,1)./src_pts(:,3);
Vq = src_pts(:,2)./src_pts(:,3);
points_query = [Uq Vq];

U = 1:size(src_img,1);
V = 1:size(src_img,2);
V = V';

%size(V), size(U), size(src_img), size(points_query(:,1)) ,size(points_query(:,2))
red_channel = interp2(V, U, src_img(:,:,1), points_query(:,1), points_query(:,2),'linear', 0);
green_channel = interp2(V, U, src_img(:,:,2), points_query(:,1) ,points_query(:,2),'linear', 0);
blue_channel = interp2(V, U, src_img(:,:,3), points_query(:,1) ,points_query(:,2),'linear', 0);
target_points = [red_channel green_channel blue_channel];
result_img = reshape(target_points, [dest_canvas_width_height(2), dest_canvas_width_height(1), 3]);
R = red_channel~=0;
G = green_channel~=0;
B = blue_channel~=0;
mask = [R&G&B];
mask = reshape([R G B], [dest_canvas_width_height(2), dest_canvas_width_height(1), 3]);
mask = mask(:,:,1);