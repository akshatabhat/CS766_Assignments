function dest_pts_nx2 = applyHomography(H_3x3, src_pts_nx2)
input = [src_pts_nx2 ones(size(src_pts_nx2,1),1)];
temp = input * H_3x3;
z = temp(:,3);
dest_pts_nx2 = [temp(:,1)./z temp(:,2)./z];
