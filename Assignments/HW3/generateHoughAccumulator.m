function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)
theta_step = 180/theta_num_bins;
theta = -90:theta_step:90-theta_step;
% To calculate rho, we need to calcuate diagnal length of the image
% diag = sqrt((size(img,1)-1)^2+(size(img,2)-1)^2)
max_diag = 800;
rho_step = (2 * max_diag + 1)/rho_num_bins;
rho = -max_diag:rho_step:max_diag;
A = zeros(size(rho,2), size(theta,2));
[y x] = find(img);
for idx=1:length(y)
    for t=1:size(theta,2)
        p =  x(idx) * cosd(theta(t)) + y(idx) * sind(theta(t));
        temp = (p-rho(1,1))/rho_step;
        index = round(temp)+1;
        A(index,t) = A(index,t) + 1;
    end
end
hough_img = rescale(A,0,255);
    
