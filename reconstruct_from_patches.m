
function output = reconstruct_from_patches(patches, image_size, patch_size, stride)
    H = image_size(1);
    W = image_size(2);
    output = zeros(H, W);
    weight = zeros(H, W);

    patch_len = size(patches, 1);
    patch_area = patch_size * patch_size;

    if mod(patch_len, patch_area) ~= 0
        error('❌ Cannot reshape patches. Mismatch in vector length.');
    end

    num_channels = patch_len / patch_area;

    idx = 1;
    for i = 1:stride:H - patch_size + 1
        for j = 1:stride:W - patch_size + 1
            patch = reshape(patches(:, idx), [patch_size, patch_size, num_channels]);
            if num_channels > 1
                patch = sum(patch, 3);  % collapse to grayscale
            end
            output(i:i+patch_size-1, j:j+patch_size-1) = output(i:i+patch_size-1, j:j+patch_size-1) + patch;
            weight(i:i+patch_size-1, j:j+patch_size-1) = weight(i:i+patch_size-1, j:j+patch_size-1) + 1;
            idx = idx + 1;
        end
    end

    output = output ./ (weight + eps);
end
