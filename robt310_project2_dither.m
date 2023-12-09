function robt310_project2_dither(input_file_name, output_file_name, part)
if part==0
gray=(im2gray(imread(input_file_name)));
gray_size=size(gray);
gray=im2double(gray);
dithered=zeros(gray_size);
for i=1:size(gray,1)
    if mod(i,2) == 0
            cOrder = 1:size(gray,2); 
            direction = 'l2r';
    else 
            cOrder = size(gray,2):-1:1; 
            direction = 'r2l';
    end  
    for j = cOrder
            tp = gray(i,j);
            if tp>=0.5
                dithered(i,j) = 1; 
            else
                dithered(i,j) = 0;
            end
            ep = tp-dithered(i,j);
            if i~=size(gray,1)
                switch direction
                    case 'l2r'
                        if j == 1 
                            gray(i,j+1) = gray(i,j+1)+ep*7/16;
                            gray(i+1,j) = gray(i+1,j)+ep*5/16;
                            gray(i+1,j+1) = gray(i+1,j+1)+ep*1/16; 
                        elseif j == size(gray,2)
                            gray(i+1,j) = gray(i+1,j)+ep*5/16;
                            gray(i+1,j-1) = gray(i+1,j-1)+ep*3/16;
                        else
                            gray(i,j+1) = gray(i,j+1)+ep*7/16;
                            gray(i+1,j) = gray(i+1,j)+ep*5/16;
                            gray(i+1,j+1) = gray(i+1,j+1)+ep*1/16;
                            gray(i+1,j-1) = gray(i+1,j-1)+ep*3/16;
                        end
                    case 'r2l'
                        if j == size(gray,2)
                            gray(i,j-1) = gray(i,j-1)+ep/16;
                            gray(i+1,j) = gray(i+1,j)+ep*3/16;
                            gray(i+1,j-1) = gray(i+1,j-1)+ep*1/16; 
                        elseif j == 1
                            gray(i+1,j) = gray(i+1,j)+ep*5/16;
                            gray(i+1,j+1) = gray(i+1,j+1)+ep*3/16;
                        else
                            gray(i,j-1) = gray(i,j-1)+ep*7/16;
                            gray(i+1,j) = gray(i+1,j)+ep*5/16;
                            gray(i+1,j-1) = gray(i+1,j-1)+ep*1/16;
                            gray(i+1,j+1) = gray(i+1,j+1)+ep*3/16;
                        end
                end
            else 
                switch direction
                    case 'l2r'
                        if j ~=size(gray,2)
                            gray(i,j+1) = gray(i,j+1)+ep*7/16;
                        end
                    case 'r2l'
                        if j ~= 1
                            gray(i,j-1) = gray(i,j-1)+ep*3/16;
                        end
                end
            end
    end
end
imwrite(dithered, output_file_name);
else
    disp('extra task should have been here')
end
end