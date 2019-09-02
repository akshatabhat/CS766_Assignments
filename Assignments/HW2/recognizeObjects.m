function output_img = recognizeObjects(orig_img, labeled_img, obj_db)
[my_obj_db, out_img] = compute2DProperties(orig_img, labeled_img);
diff_4_threshold = 30;
diff_6_threshold = 0.03;
threshold = 2100;
fh1 = figure();
imshow(orig_img);
hold on
for i=1:size(obj_db,2)
    for j=1:size(my_obj_db,2)
        diff_4 = abs(obj_db(4,i)-my_obj_db(4,j));
        diff_6 = abs(obj_db(6,i)-my_obj_db(6,j));
        if diff_4 < diff_4_threshold && diff_6 < diff_6_threshold && diff_4/diff_6 < threshold
            %fprintf("i=%d,j=%d,diff_4=%f,diff_5=%f, star=%f \n",i,j,diff_4,diff_6, diff_4/diff_6);
            x_delta = (50*cos(my_obj_db(5,j)));
            y_delta = (50*sin(my_obj_db(5,j)));
            x1 = my_obj_db(2,j)+x_delta;
            x2 = my_obj_db(2,j)-x_delta;
            y1 = my_obj_db(3,j)+y_delta;
            y2 = my_obj_db(3,j)-y_delta;
            hold on;
            plot([x1 x2],[y1 y2], "Linewidth",1);
            hold on;
            plot(my_obj_db(2,j), my_obj_db(3,j),'ws', 'MarkerFaceColor', [1 0 0]);
            
        end
    end
end
output_img = saveAnnotatedImg(fh1);

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