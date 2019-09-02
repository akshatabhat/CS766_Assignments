function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)
rho_num_bins=size(hough_img,1);
theta_num_bins=size(hough_img,2);

theta_step = 180/theta_num_bins;
theta = -90:theta_step:90-theta_step;
max_diag = 800;
rho_step = (2 * max_diag + 1)/rho_num_bins;
rho = -max_diag:rho_step:max_diag;

theta_peak = [];
rho_peak = [];
for i=1:rho_num_bins
    for j=1:theta_num_bins
        if  hough_img(i,j)> hough_threshold 
            theta_peak = [theta_peak ; theta(j)];
            rho_peak = [rho_peak ; rho(i)];
        end
    end
end
theta_peak = theta_peak * theta_step;
rho_peak = rho_peak * rho_step;
fh1 = figure; imshow(orig_img);
hold on
%[theta_peak rho_peak]
for i=1:length(theta_peak)
    x = [0 640];
    y = (rho_peak(i)- x * cosd(theta_peak(i)))/sind(theta_peak(i));
    line(x,y, 'LineWidth',2, 'Color', [1, 0, 0]);
end

line_detected_img = saveAnnotatedImg(fh1);
delete(fh1);


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
