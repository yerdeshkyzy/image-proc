function robt310_project2_histogram_equalize(input_file_name)
figure
imshow(histeq(imread(input_file_name)));
fun=@(block_struct) histeq(block_struct.data);
Histogram=blockproc(histeq(imread(input_file_name)),[400 400], fun);
figure
imshow(Histogram);
end