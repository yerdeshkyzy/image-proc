function robt310_project2_interpolation(input_file_name, output_file_name, scale_factor)
gray=(im2gray(imread(input_file_name)));
graysize=size(gray);
gray=im2double(gray);
intrpld=zeros(scale_factor*graysize);
for i=1:size(intrpld,1)
    for j=1:size(intrpld,2)
        intrpld(i,j)=gray(ceil(i/scale_factor),ceil(j/scale_factor));
    end
end
imwrite(intrpld, output_file_name);
end
