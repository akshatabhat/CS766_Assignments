function [normals, albedo_img] = ...
    computeNormals(light_dirs, img_cell, mask)
img_size = size(img_cell{1});

images = zeros(size(img_cell,1), img_size(1), img_size(2));
for i=1:size(img_cell,1)
    images(i,:,:) = img_cell{i};
end
normals = zeros(img_size(1), img_size(2), 3);
albedo_img = zeros(img_size);
for i=1:img_size(1,1)
    for j=1:img_size(1,2)
        if mask(i,j)
            I = images(:, i, j);
            S = light_dirs;
            N = inv(S'*S)*S'*I;
            normals(i, j, :) = N/norm(N);
            albedo_img(i, j) = norm(N);
        else
            normals(i, j, :) = [0 0 0]; 
        end
    end
end
albedo_img = normalize(albedo_img,'range');