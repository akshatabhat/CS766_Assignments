function H_3x3 = computeHomography(src_pts_nx2, dest_pts_nx2)

r1 = [-src_pts_nx2(:,1) -src_pts_nx2(:,2) -ones(4,1) zeros(4,3) dest_pts_nx2(:,1).*src_pts_nx2(:,1) dest_pts_nx2(:,1).*src_pts_nx2(:,2) dest_pts_nx2(:,1)];
r2 = [zeros(4,3) -src_pts_nx2(:,1) -src_pts_nx2(:,2) -ones(4,1) dest_pts_nx2(:,2).*src_pts_nx2(:,1) dest_pts_nx2(:,2).*src_pts_nx2(:,2) dest_pts_nx2(:,2)];
A = [r1; r2];
[V,~] = eig(A'*A);
H_3x3 = -[V(1:3); V(4:6); V(7:9)]';