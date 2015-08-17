%Attention Prediction in Egocentric Video Using Motion and Visual Saliency
%Yamada, Sugano, Okabe, Sato, Sugimoto, Hiraki

%presets
run('C:\Users\Alicia\dev\vlfeat-0.9.20\toolbox\vl_setup');
numSamples = 250;
numFrames = 10;
cameraParams = load('pivotheadParameters2.mat');
cameraParams = cameraParams.pivotheadParameters;
K = cameraParams.IntrinsicMatrix'
%data
vid = VideoReader('data\head_test.mp4');
start = 100;
frame = read(vid, start);
resultFrames = [];
corners = cv.goodFeaturesToTrack(rgb2gray(frame), 'MaxCorners', 250);
c_det = [corners{:}];
c_det = reshape(c_det,[2 size(corners,2)])';

for i=1:numFrames
    frame_prev = frame;
    corners_prev = corners;
    c_prev = c_det;
    frame = read(vid, start+i);
    
    %find features
    corners = cv.calcOpticalFlowPyrLK(rgb2gray(frame_prev), rgb2gray(frame), corners_prev);
    %if(size(corners,2) < 500)
        %fix to add, not replace
        %corners = cv.goodFeaturesToTrack(rgb2gray(frame));
    %end
    c_det = [corners{:}];
    c_det = reshape(c_det,[2 size(corners,2)])';


    perm = randperm(min([size(c_prev,1) size(c_det,1)]));
    sampleRange = perm(1:numSamples);

    %     fig = figure('Name', 'Image');
    %     showMatchedFeatures(frame_prev, frame, c_prev, c_det);
    %     imshow(frame);
    %     resultFrames = cat(4, resultFrames, saveFrame(fig));
    %     hold on;
    %     scatter(c_prev(sampleRange,1), c_prev(sampleRange,2), 30, 'b');
    %     scatter(c_det(sampleRange,1), c_det(sampleRange,2), 30, 'r');
    %     hold off;

    %Fundamental matrix
    F = cv.findFundamentalMat(corners_prev, corners, 'Method', 'Ransac', 'Param1', 1e-3);


    h_prev = [c_prev ones(size(c_prev,1),1)]';
    h_det = [c_det ones(size(c_det,1),1)]';
% 
    fErrs = zeros(numSamples,1);
    for s=1:numSamples
        fErrs(s,1) = abs(h_prev(:,s)' * F * h_det(:,s));
    end
    
    Fmatlab = estimateFundamentalMatrix(c_prev, c_det, 'Method', 'RANSAC', 'DistanceThreshold', 1e-3, 'NumTrials', 2000);
    fErrs2 = zeros(numSamples,1);
    for s=1:numSamples
        fErrs2(s,1) = abs(h_prev(:,s)' * Fmatlab * h_det(:,s));
    end
    if median(fErrs2) < median(fErrs)
        F = Fmatlab;
        sprintf('2Fundamental Matrix error:\n Mean: %f, Max: %f, Median: %f', mean(fErrs2), max(fErrs2), median(fErrs2))
    else
        sprintf('1Fundamental Matrix error:\n Mean: %f, Max: %f, Median: %f', mean(fErrs), max(fErrs), median(fErrs))       
    end
    F = enforceRank2(F);    
         
    h_prev_n = K \ h_prev;
    h_det_n = K \ h_det;
    E = K'*F*K;
    [U, S, V] = svd(E);
    abs(S(1,1) - S(2,2));
    s = mean([S(1,1) S(2,2)]);
    Enew = s*U*diag([1 1 0])*V';
    [U, S, V] = svd(Enew);

    eErrs = size(numSamples,1);
    for s=1:numSamples
        eErrs(s,1) = abs(h_prev_n(:,s)' * Enew * h_det_n(:,s));
    end
    sprintf('New Essential Matrix error:\n Mean: %f, Max: %f, Median: %f', mean(eErrs), max(eErrs), median(eErrs))

    W = [0 -1 0; 1 0 0; 0 0 1];
    R1 = U*W*V';
    R2 = U*W'*V';
    t1 = null(Enew');
    t2 = -null(Enew');
    
    h_prev_nn = [h_prev_n; ones(1,size(h_prev_n,2))];
    h_det_nn = [h_det_n; ones(1,size(h_det_n,2))];
    
    h_pred1 = K * [R1 t1] * h_prev_nn;
    h_pred2 = K * [R2 t1] * h_prev_nn;
    h_pred3 = K * [R1 t2] * h_prev_nn;
    h_pred4 = K * [R2 t2] * h_prev_nn;

    fig = figure('Name', 'Image');
    visualizeEpipoleLines(F, c_prev, frame_prev, c_det, frame);
    hold on;
    scatter(h_det(1,sampleRange), h_det(2,sampleRange), 30, 'b');
    scatter(h_pred1(1,sampleRange), h_pred1(2,sampleRange), 30, 'r');
    scatter(h_pred2(1,sampleRange), h_pred2(2,sampleRange), 30, 'g');
    scatter(h_pred3(1,sampleRange), h_pred3(2,sampleRange), 30, 'y');
    scatter(h_pred4(1,sampleRange), h_pred4(2,sampleRange), 30, 'p');
    hold off;
    resultFrames = cat(4, resultFrames, saveFrame(fig));

end

implay(resultFrames);