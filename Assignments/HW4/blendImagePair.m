function out_img = blendImagePair(wrapped_imgs, masks, wrapped_imgd, maskd, mode)
if strcmp(mode, 'overlay')
    maskd = uint8(maskd==255);
    masks = uint8(~maskd);
    out_img = wrapped_imgs.*cat(3, masks, masks, masks) + wrapped_imgd.*cat(3, maskd, maskd, maskd);
else
    masks = (masks==0);
    maskd = (maskd==0);
    weighted_masks = double(rescale(bwdist(masks, 'euclidean')));
    weighted_maskd = double(rescale(bwdist(maskd, 'euclidean')));
    weighted_masks = cat(3, weighted_masks, weighted_masks, weighted_masks);
    weighted_maskd = cat(3, weighted_maskd, weighted_maskd, weighted_maskd);
    out_img =(double(wrapped_imgs).*weighted_masks + double(wrapped_imgd).*weighted_maskd)./(weighted_masks + weighted_maskd);
    out_img(isnan(out_img)) = 0;
    out_img = uint8(out_img);
end
