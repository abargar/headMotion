function [ ] = plotRT( allR, t )
%PLOTRT Summary of this function goes here
%   Detailed explanation goes here
numRs = size(allR,3);
theta_x = zeros(1,numRs);
theta_y = zeros(1,numRs);
theta_z = zeros(1,numRs);
trans_x = zeros(1,numRs);
trans_y = zeros(1,numRs);
for i =1:numRs
    R = allR(:,:,i);
    theta_x(i) = atan2(R(3,2), R(3,3));
    theta_y(i) = atan2(-R(3,1), sqrt(R(3,2)^2 + R(3,3)^2));
    theta_z(i) = atan2(R(2,1), R(1,1));
    trans_x(i) = abs(t(1,i));
    trans_y(i) = abs(t(2,i));
% X = [1 0 0; 0 cos(theta_x) -sin(theta_x); 0 sin(theta_x) cos(theta_x)];
% Y = [cos(theta_y) 0 sin(theta_y); 0 1 0; -sin(theta_y) 0 cos(theta_y)];
% Z = [cos(theta_z) -sin(theta_z) 0; sin(theta_z) cos(theta_z) 0; 0 0 1];
end
figure('Name', 'ThetaX'), plot(theta_x);
figure('Name', 'ThetaY'), plot(theta_y);
figure('Name', 'ThetaZ'), plot(theta_z);
figure('Name', 'TransX and TransY'), plot3(1:numRs, trans_x, trans_y);
end

