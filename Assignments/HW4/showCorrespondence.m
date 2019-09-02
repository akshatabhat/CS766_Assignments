function result_img = ...
    showCorrespondence(orig_img, warped_img, src_pts_nx2, dest_pts_nx2)
f1 = figure(1);
combined_img = [orig_img warped_img];
width = size(orig_img, 2);
imshow(combined_img);
for i = 1:size(src_pts_nx2,1)
    line([src_pts_nx2(i,1) dest_pts_nx2(i,1)+width], [src_pts_nx2(i,2) dest_pts_nx2(i,2)], 'LineWidth',2, 'Color', [1,0, 0]);
end
result_img = saveAnnotatedImg(f1);
function annotated_img = saveAnnotatedImg(fh)
figure(fh); % Shift the focus back to the figure fh

% The figure needs to be undocked
set(fh, 'WindowStyle', 'normal');

% The following two lines just to make the figure true size to the
% displayed image. The reason will become clear later.
img = getimage(fh);
truesize(fh, [size(img, 1), size(img, 2)]);

% getframe does a screen capture of the figure window, as a result, the
% displayed figure has to be in true size. 
frame = getframe(fh);
frame = getframe(fh);
pause(0.5); 
% Because getframe tries to perform a screen capture. it somehow 
% has some platform depend issues. we should calling
% getframe twice in a row and adding a pause afterwards make getframe work
% as expected. This is just a walkaround. 
annotated_img = frame.cdata;
