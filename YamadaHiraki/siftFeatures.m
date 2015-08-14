%sift
% % frame_prev = im2single(rgb2gray(frame_prev));
% % [fp, dp] = vl_sift(frame_prev);
% % frame = im2single(rgb2gray(frame));
% % [f, d] = vl_sift(frame);
% %match
% % [matches, scores] = vl_ubcmatch(dp, d) ;
% % perm = randperm(size(matches,2));
% % sel = perm(1:50);
% % 
% % pair = createImagePair(frame_prev, frame);
% % f_offset = f;
% % f_offset(1,:) = f_offset(1,:) + size(frame,2);
% % numMatches = size(matches,2);
% % 
% % selMatches = matches(:,sel);
% % matchLines = getMatchLines(matches(:,1:50), fp, f_offset);
% % figure('Name', 'Matches'), imshow(pair);
% % hold on
% % vl_plotframe(fp);
% % vl_plotframe(f_offset);
% % matchLineColor = hsv(size(sel,2));
% % for m=1:size(sel,2)
% %     line(matchLines(2*m-1:2*m,1),matchLines(2*m-1:2*m,2), 'color', matchLineColor(m,:))
% % end
% % hold off
% %     
    % while CONDITION
    
%     numSamples = 8;
%     perm = randperm(min([size(c_prev,1) size(c_det,1)]));
%     sampleRange = perm(1:numSamples);
%     s_prev = c_prev(sampleRange,:);
%     s_det = c_det(sampleRange,:);
%     F = part2_2(part2_1(s_prev, s_det))
%     part2_3(F, s_prev, frame_prev, s_det, frame);
    
% end