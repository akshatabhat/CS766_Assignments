function result = computeFlow(img1, img2, win_radius, template_radius, grid_MN)

step_y = size(img1,1)/grid_MN(1);
step_x = size(img1,2)/grid_MN(2);

optical_flow = [];
for y=1:step_y:size(img1,1)
    for x=1:step_x:size(img1,2)
        temp_ymin = max(1, y-template_radius);
        temp_ymax = min(size(img1,1),y+template_radius);
        temp_xmin = max(1, x-template_radius);
        temp_xmax = min(size(img1,2),x+template_radius);
        template = img1(temp_ymin:temp_ymax,temp_xmin:temp_xmax);
        
        swind_ymin = max(1, y-win_radius);
        swind_ymax = min(size(img2,1),y+win_radius);
        swind_xmin = max(1, x-win_radius);
        swind_xmax = min(size(img2,2),x+win_radius);
        search_wind = img2(swind_ymin:swind_ymax,swind_xmin:swind_xmax);
        
        c = normxcorr2(template, search_wind);
        c = c(size(template, 1) : size(c, 1) - size(template, 1), size(template, 2) : size(c, 2) - size(template, 2));
        [ypeak, xpeak] = find(c==max(c(:)));
        optical_flow = [optical_flow; [x, y, xpeak(1)-(temp_xmin-swind_xmin+1), ypeak(1)-(temp_ymin-swind_ymin+1)]];
    end
end

fh1 = figure();
imshow(img1);
hold on
needle_plot = quiver(optical_flow(:,1),optical_flow(:,2),optical_flow(:,3),optical_flow(:,4))
result = saveAnnotatedImg(fh1);

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


