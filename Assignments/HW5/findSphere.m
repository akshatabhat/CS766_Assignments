function [center, radius] = findSphere(img)
bw_img = im2bw(img);
s = regionprops(bw_img,'centroid', 'Area');
center = s.Centroid;
radius = sqrt(s.Area/(pi));