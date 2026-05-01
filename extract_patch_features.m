
function [features] = extract_patch_features(img, patch_size, stride)
    % Compute gradients
    fx = [-1 0 1];
    fy = fx';

    Ix = imfilter(img, fx, 'replicate');
    Iy = imfilter(img, fy, 'replicate');

    Ixx = imfilter(Ix, fx, 'replicate');
    Iyy = imfilter(Iy, fy, 'replicate');

    % Stack gradients
    grad_stack = cat(3, Ix, Iy, Ixx, Iyy);  % [H x W x 4]

    [h, w, ~] = size(grad_stack);
    features = [];

    for i = 1:stride:(h - patch_size + 1)
        for j = 1:stride:(w - patch_size + 1)
            patch = grad_stack(i:i+patch_size-1, j:j+patch_size-1, :);
            vec = patch(:);  % [patch_size * patch_size * 4 x 1]
            features = [features, vec];
        end
    end
end
