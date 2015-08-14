function [result_frame] = calibrateCamera(frame)
cameraParams = load('utility\pivotheadParameters.mat');
cameraParams = cameraParams.pivotheadParameters;
% figure('Name', 'Original'), imshow(frame);
[result_frame] = undistortImage(frame, cameraParams);
% figure('Name', 'Result'), imshow(result_frame);

end