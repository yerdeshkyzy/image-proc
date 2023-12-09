%% 1.1)
Template=zeros([1000 1000]);
for i=1:size(Template,2)
    for j=1:size(Template,1)
        Template(j, i)=100/256;
    end
end
subplot(1,5,1)
imshow(Template)


%% 1.2)
future_strips = zeros([1000 1000]);
for i=1:size(future_strips,2)
    if(mod(i,8) == 1 || mod(i,8) == 2 || mod(i,8) == 3 || mod(i,8) == 4)
        future_strips(:,i,:) = 1;       
    end
end
subplot(1,5,2)
imshow(future_strips)

%% 1.3)
half_intensity=zeros([1000 1000]);
for i=1:size(half_intensity,2)
    for j=1:size(half_intensity,1)
        half_intensity(j, i)=(j/2)/256;
    end
end
subplot(1,5,3)
imshow(half_intensity)

%% 1.4)
forth_part=zeros([1000 1000]);
for i=1:size(forth_part,2)
    for j=1:size(forth_part,1)
        forth_part(j, i)=(255*exp(-(((j-128)^2+(i-128)^2)/200^2)))/256;
    end
end
subplot(1,5,4)
imshow(forth_part)

%% 1.5)
subplot(1,5,5)
rectangle('Position',[0 500 500 500],'FaceColor',[1 1 0],'EdgeColor',[1 1 0])
rectangle('Position',[0 0 500 500],'FaceColor',[1 0 0],'EdgeColor',[1 0 0])
rectangle('Position',[500 500 500 500],'FaceColor',[0 1 0],'EdgeColor',[0 1 0])
rectangle('Position',[500 0 500 500],'FaceColor',[0 0 0],'EdgeColor',[0 0 0]);