number_of_patches = 200;
photo_size_ratio = 1;
end_result_image = 'mosaic.png';
distance = 3;
types_of_files = {['*.JPEG;*.JPG;*.PNG;'],'MATLAB Graphical Files'};
other_types_of_files = {'BMP' 'GIF' 'HDF' 'JPEG' 'JPG' 'PBM' 'PCX' 'PGM' ...
    'PNG' 'PNM' 'PPM' 'RAS' 'TIFF' 'TIF' 'XWD'};
% get the directory of images
imagePath = uigetfile(types_of_files, 'Select the main mosiac image');
imageDirect = uigetdir()
% original img size
mIm = imread(imagePath);
img_size = size(mIm);


% set size based on original size
t_pxls = floor(img_size(1)/number_of_patches);
t_size = [t_pxls t_pxls];
nh = floor(img_size(2)/t_pxls);
nT = [number_of_patches nh];
nsize = [number_of_patches nh].*t_pxls;
mIm = imresize(mIm, nsize);
% get all images
photos_directory = dir(imageDirect);
m_index = 1;
%For each image add it to array
for directory_ind = 1:length(photos_directory)
    if ~photos_directory(directory_ind).isdir
        file_name = photos_directory(directory_ind).name;
        %Check file extension
        [~, ~, ext] = fileparts(file_name);
        if max(strcmpi(ext(2:end), other_types_of_files))
            mosaic_files{m_index} = file_name;
            m_index = m_index+1;
        end
    end
end
%% Resize directory images into the_patches
%progress = waitbar(0, 'Creating Mosaic Thumbnails...');
num_files = length(mosaic_files);
mosaic_imgs = cell(1, num_files);

%resize each image
for m_index = 1:num_files
    img = imread([imageDirect, filesep, mosaic_files{m_index}]);

    res_img = uint8(imresize(img, t_size*photo_size_ratio));
    the_patches{m_index} = res_img;
    %imwrite(res_img, [thumb_dir, filesep, strcat(num2str(m_index),'.jpg')], 'jpg');
   % waitbar(m_index/num_files, progress);
end

% calculating patch averages
for m_index = 1:num_files
    cur_thumb = the_patches{m_index};
    RGB_vals{m_index} = mean(reshape(cur_thumb, [], 3), 1);
 
end

%  finding the closest matching thumb
pic_map = zeros(nT);
tiles_done = 0;
for row_tile = 1:nT(1)
    for col_tile = 1:nT(2)
        closest = 1;
        shortest_dist = 1000;
        cur_tile = mIm(t_pxls*(row_tile-1)+1:t_pxls*(row_tile), ...
        t_pxls*(col_tile-1)+1:t_pxls*(col_tile),:);
        cur_RGB = mean(reshape(cur_tile, [], 3), 1);
        for thumb_tile = 1:num_files
            dist = calc_distance(RGB_vals{thumb_tile}, cur_RGB);
            if dist < shortest_dist
                if isempty(find( ...
                        pic_map(max(row_tile-distance,1): ...
                        min(row_tile+distance,nT(1)),... 
                        max(col_tile-distance,1): ...
                        min(col_tile+distance,nT(2))) ... 
                        == thumb_tile, 1))
                    shortest_dist = dist;
                    pic_map(row_tile, col_tile) = thumb_tile;
                end
            end
        end
        tiles_done = tiles_done + 1;
    end
end

% mapping of patches and create mosaic
for row_tile = 1:nT(1)
    cur_row = the_patches{pic_map(row_tile, 1)};
    for col_tile = 2:nT(2)
        cur_row = horzcat(cur_row, the_patches{pic_map(row_tile, col_tile)});
    end
    if row_tile == 1
        mosaic = cur_row;
    else
        mosaic = vertcat(mosaic, cur_row);
        clear cur_row;
    end
end

imshow(mosaic)
imwrite(mosaic, end_result_image, 'png');

function distance = calc_distance(pt1, pt2)
  distance = sqrt(sum((pt1-pt2).^2));
end