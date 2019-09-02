function [db, out_img] = compute2DProperties(orig_img, labeled_img)
bw = orig_img;
cc = bwconncomp(labeled_img);
num_obj  = cc.NumObjects;
db = zeros(6, num_obj);
fh1 = figure();
imshow(orig_img);
hold on
for i=1:num_obj
    f=(labeled_img==i);
    Area=sum(sum(f));
    [R,C]=meshgrid(1:size(bw,2),1:size(bw,1));
    centroid=[sum(sum(R.*f))/Area, sum(sum(C.*f))/Area];
    db(1,i) = i;
    db(2,i) = round(centroid(1));
    db(3,i) = round(centroid(2));
    
    %Shifting the coordinate system
    R = R - centroid(1);
    C = C - centroid(2);
    
    a = sum(sum(R.^2.*f))/Area;
    b = 2 * sum(sum(R .* C .*f))/Area;
    c = sum(sum(C.^2.*f))/Area;
    
    denom = b^2 + (a-c)^2;
    theta_1 = atan2(b, a-c)/2;
    theta_2 = theta_1 + pi/2;
    E_min = a * sin(theta_1).^2 - b*sin(theta_1)*cos(theta_1) + c * cos(theta_1).^2;
    E_max = a * sin(theta_2).^2 - b*sin(theta_2)*cos(theta_2) + c * cos(theta_2).^2;
    roundness = E_min/E_max;
    
    db(4,i) = E_min;
    db(5,i) = theta_1;
    db(6,i) = roundness;

    % Plotting the orientation
    x_delta = (50*cos(theta_1));
    y_delta = (50*sin(theta_1));
    x1 = db(2,i)+x_delta;
    x2 = db(2,i)-x_delta;
    y1 = db(3,i)+y_delta;
    y2 = db(3,i)-y_delta;
    plot([x1 x2],[y1 y2], "Linewidth",1);
end
hold on
%Ploting the centroid of objects
plot(db(2,:), db(3,:),'ws', 'MarkerFaceColor', [1 0 0]);
out_img = saveAnnotatedImg(fh1);
%%
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