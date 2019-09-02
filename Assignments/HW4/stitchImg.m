function stitched_img = stitchImg(varargin)
simg = double(varargin{1});
for i=2:length(varargin)
    base_img = double(varargin{i});
    ransac_n = 100;
    ransac_eps = 0.1;
    [xs, xd] = genSIFTMatches(simg, base_img);
    [inline_id, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);
    base_img_size = size(base_img);
    % Finding bounding box
    [X, Y]=meshgrid(1:size(simg,2),1:size(simg,1));
    src_pts = [X(:), Y(:)];
    dest_pts_1 = applyHomography(H_3x3, src_pts);

    x_min = min(dest_pts_1(:,1));
    x_max = max(dest_pts_1(:,1));
    y_min = min(dest_pts_1(:,2));
    y_max = max(dest_pts_1(:,2));

    if x_min<0
        tx = abs(x_min);
    else
        tx = 0;
    end
    if y_min<0
        ty = abs(y_min);
    else
        ty = 0;
    end

    H_trans = [1 0 tx; 0 1 ty; 0 0 1];
    [X,Y] = meshgrid(0:abs(x_min)+base_img_size(2), 0:(y_max - y_min));
    dest_canvas_width_height = [size(X,2) size(X,1)];

    [mask, dest_img] = backwardWarpImg(simg, inv(H_trans)'*inv(H_3x3), dest_canvas_width_height);
    %figure; imshow(dest_img);
    %figure; imshow(base_img);
    mask = ~mask;

    dest_img_size = size(dest_img);
    padsize = [0, dest_img_size(2)-size(base_img,2)];
    base_img_expanded = padarray(base_img, padsize,'pre');
    padsize = [round(y_max) - size(base_img,1) 0];
    base_img_expanded = padarray(base_img_expanded, padsize,'post');
    padsize = [round(abs(y_min)) 0];
    base_img_expanded = padarray(base_img_expanded, padsize,'pre');
    padsize = dest_img_size-size(base_img_expanded);
    base_img_expanded = padarray(base_img_expanded, padsize,'pre');
    %size(base_img_expanded), size(dest_img), size(mask)
    
    r = ~base_img_expanded(:,:,1);
    g = ~base_img_expanded(:,:,2);
    b = ~base_img_expanded(:,:,3);
    mask_base = [r&g&b];
    result = blendImagePair_1(dest_img, ~mask, base_img_expanded, ~mask_base, 'blend');
    %result = base_img_expanded .* cat(3, mask, mask, mask) + dest_img;
    simg = result;
end
stitched_img = result;

function out_img = blendImagePair_1(wrapped_imgs, masks, wrapped_imgd, maskd, mode)
if strcmp(mode, 'overlay')
    maskd = uint8(maskd==255);
    masks = uint8(~maskd);
    out_img = wrapped_imgs.*cat(3, masks, masks, masks) + wrapped_imgd.*cat(3, maskd, maskd, maskd);
else
    masks = double(masks==0);
    maskd = double(maskd==0);
    weighted_masks = double(rescale(bwdist(masks, 'euclidean')));
    weighted_maskd = double(rescale(bwdist(maskd, 'euclidean')));
    weighted_masks = cat(3, weighted_masks, weighted_masks, weighted_masks);
    weighted_maskd = cat(3, weighted_maskd, weighted_maskd, weighted_maskd);
    out_img =(double(wrapped_imgs).*weighted_masks + double(wrapped_imgd).*weighted_maskd)./(weighted_masks + weighted_maskd);
    out_img(isnan(out_img)) = 0;
end
