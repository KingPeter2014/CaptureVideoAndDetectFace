% readnPlotVideoFrames % Read and plot first and last frames of a video clip
% numFrames = 300;
% videoFile = captureVideo(numFrames);
sampleVideoFile = 'lifecapture.avi';
detectedFaces = detectFace(sampleVideoFile);

len = length(detectedFaces);
numRectangles = floor(len/4);

i=1;
% while i <= len
%     rectangle('Position',detectedFaces(1,i:i+3))
%     i=i+4;
% end
% rectangle('Position',detectedFaces(1,1:4))
% axis([0 10 0 10])

