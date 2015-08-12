%Attention Prediction in Egocentric Video Using Motion and Visual Saliency
%Yamada, Sugano, Okabe, Sato, Sugimoto, Hiraki

%presets
run('C:\Users\Alicia\dev\vlfeat-0.9.20\toolbox\vl_setup');
intrinsicMatrix = load('pivotheadParameters.mat', 'IntrinsicMatrix');
%data
vid = VideoReader('data\checkerboard\most-poses.mp4');
i = 320;
frame_prev = read(vid, i);
frame = read(vid,i+1);

% % figure('Name', 'Image Prev'), imshow(frame_prev);
% % figure('Name', 'Image'), imshow(frame);

%find features
%sift
% % frame_prev = im2single(rgb2gray(frame_prev));
% % [fp, dp] = vl_sift(frame_prev);
% % frame = im2single(rgb2gray(frame));
% % [f, d] = vl_sift(frame);

%Shi-Tomasi features
corners_prev = cv.goodFeaturesToTrack(rgb2gray(frame_prev));
detected_corners = cv.calcOpticalFlowPyrLK(rgb2gray(frame_prev), rgb2gray(frame), corners_prev);

c_prev = [corners_prev{:}];
c_prev = reshape(c_prev,[2 1000])';
c_det = [detected_corners{:}];
c_det = reshape(c_det,[2 1000])';

numSamples = 8;
perm = randperm(min([size(c_prev,1) size(c_det,1)]));
sampleRange = perm(1:numSamples);

figure('Name', 'Image Prev'), imshow(frame_prev);
hold on;
scatter(c_prev(sampleRange,1), c_prev(sampleRange,2));
hold off;

figure('Name', 'Test'), imshow(frame);
hold on;
scatter(c_det(sampleRange,1), c_det(sampleRange,2));
hold off;

%RANSAC

% while CONDITION
    
    numSamples = 8;
    perm = randperm(min([size(c_prev,1) size(c_det,1)]));
    sampleRange = perm(1:numSamples);
    s_prev = c_prev(sampleRange,:);
    s_det = c_det(sampleRange,:);
    F = part2_2(part2_1(s_prev, s_det))
    part2_3(F, s_prev, frame_prev, s_det, frame);
    
% end

%match
% [matches, scores] = vl_ubcmatch(dp, d) ;
% perm = randperm(size(matches,2));
% sel = perm(1:50);
% 
% pair = createImagePair(frame_prev, frame);
% f_offset = f;
% f_offset(1,:) = f_offset(1,:) + size(frame,2);
% numMatches = size(matches,2);
% 
% selMatches = matches(:,sel);
% matchLines = getMatchLines(matches(:,1:50), fp, f_offset);
% figure('Name', 'Matches'), imshow(pair);
% hold on
% vl_plotframe(fp);
% vl_plotframe(f_offset);
% matchLineColor = hsv(size(sel,2));
% for m=1:size(sel,2)
%     line(matchLines(2*m-1:2*m,1),matchLines(2*m-1:2*m,2), 'color', matchLineColor(m,:))
% end
% hold off
% 
% %ransac.. once I fix the stupid thing
