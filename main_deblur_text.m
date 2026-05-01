clc;
clear;
close all;

% ================= INPUT / OUTPUT FOLDERS =================
inputFolder  = 'input_images';
outputFolder = 'output_results';

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

% ================= GET ALL IMAGE FILES =================
imgFiles = [ ...
    dir(fullfile(inputFolder,'*.png')); ...
    dir(fullfile(inputFolder,'*.jpg')); ...
    dir(fullfile(inputFolder,'*.jpeg')) ...
];

if isempty(imgFiles)
    error('No images found in input_images folder');
end

% ================= PROCESS EACH IMAGE =================
for k = 1:length(imgFiles)

    fileName = imgFiles(k).name;
    filePath = fullfile(inputFolder, fileName);

    fprintf('Processing %s...\n', fileName);

    %% =============== READ IMAGE =================
    img = imread(filePath);
    if ndims(img) == 3
        img = rgb2gray(img);
    end
    img = im2double(img);

    %% =============== BLANK IMAGE CHECK =================
    if std(img(:)) < 0.01
        out = ones(size(img));
        [~,name,~] = fileparts(fileName);
        imwrite(out, fullfile(outputFolder,[name '_CLEAR_TEXT.png']));
        continue;
    end

    %% =============== CONTRAST & DENOISE =================
    img = imadjust(img, stretchlim(img,[0.01 0.99]), []);
    img = medfilt2(img,[3 3]);

    %% =============== SAFE SHARPEN =================
    if std(img(:)) > 0.06
        img = imfilter(img, fspecial('unsharp',0.15),'replicate');
    end

    %% =============== BINARIZATION =================
    bw = im2bw(img, graythresh(img));

    if mean(img(bw)) > mean(img(~bw))
        bw = ~bw;
    end

    bw = bwareaopen(bw, 20);

    %% =============== IMAGE TYPE DETECTION =================
    fgRatio = mean(bw(:));

    filled = imfill(bw,'holes');
    solidityRatio = sum(bw(:)) / max(sum(filled(:)),eps);

    %% =============== ADAPTIVE MORPHOLOGY =================
    if fgRatio > 0.35
        % Very bold text
        bw = imerode(bw, strel('disk',1));

    elseif solidityRatio < 0.75
        % Fragile / blurred text
        bw = imfill(bw,'holes');
        bw = imclose(bw, strel('disk',1));
        % no erosion here

    else
        % Normal text
        bw = bwmorph(bw,'clean');
    end

    %% =============== FINAL CLEAN =================
    bw = bwareaopen(bw, 30);
    bw = bwmorph(bw,'clean');

    %% =============== OUTPUT =================
    out = ones(size(bw));
    out(bw) = 0;

    %% =============== SAVE =================
    [~,name,~] = fileparts(fileName);
    imwrite(out, fullfile(outputFolder,[name '_CLEAR_TEXT.png']));

    %% =============== DISPLAY (OPTIONAL) =================
    figure;
    imshow(out);
    title(['Clear Text Output: ' fileName]);

end

disp('? All images processed from input_images folder and saved to output_results');
