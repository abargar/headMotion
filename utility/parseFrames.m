function [  ] = parseFrames( path, format, interval, beginning)

video = VideoReader(sprintf('%s.%s',path,format));

folderName = sprintf('%s',path);

if ~ exist(folderName, 'dir')
    mkdir(folderName);
end

numFrames = 1;%video.NumberOfFrames;

for i=0:interval:numFrames
   frame = read(video, beginning + i);
   name = sprintf('%s/%s%d.jpg', path, path, beginning + i);
   imwrite(frame, name);
end 

end

