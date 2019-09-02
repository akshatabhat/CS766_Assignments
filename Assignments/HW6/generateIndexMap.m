function index_map = generateIndexMap(gray_stack, w_size)
stack_size = size(gray_stack);
focus_measure = zeros(stack_size);
a=[-1 2 -1];
b=a';
for i=1:stack_size(3)
    img = double(gray_stack(:,:,i));
    img1=imfilter(img,a,'replicate','conv');
    img2=imfilter(img,b,'replicate','conv');
    ML=abs(img1)+abs(img2);
    H = fspecial('average',[2*w_size, 2*w_size]);
    focus_measure(:,:,i) = imfilter(ML, H, 'replicate');
end
[~, index_map] = max(focus_measure, [], 3);

