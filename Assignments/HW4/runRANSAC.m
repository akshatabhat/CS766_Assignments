function [inliers_id, H] = runRANSAC(Xs, Xd, ransac_n, eps)
total_samples = size(Xs,1);
max_M = 0;
for i=1:ransac_n
    idxs = randsample(total_samples,4);
    src_pts_nx2 = Xs(idxs,:);
    dest_pts_nx2 = Xd(idxs,:);
    H_3x3 = computeHomography(src_pts_nx2, dest_pts_nx2);
    Xd_pred = applyHomography(H_3x3, Xs);
    err = sqrt((Xd_pred(:,1)-Xd(:,1)).^2 + (Xd_pred(:,2)-Xd(:,2)).^2);
    M = sum(err < eps);
    if M > max_M
        max_M = M;
        inliers_id = find(err < eps);
        H = H_3x3;
    end
end