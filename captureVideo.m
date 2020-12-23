function videoFile = captureVideo(numFrames)
%captureVideo Capture video using default camera in the computer
% numFrames - number of frames to be captured or video length
%output: videoFile - Unique filename of captured video

%%Get video and images from camera

cam = webcam;% Connect to the webcam.
cam.Resolution = '640x480';
%preview(cam);

% To acquire a single frame, use the snapshot function.
img = snapshot(cam);

% Display the frame in a figure window.
image(img);

% Open video file for writing
filename = strcat('lifecapture',num2str(ceil(now)),'.avi');
vidWriter = VideoWriter(filename);
open(vidWriter);
for index = 1:numFrames
    % Acquire frame for processing
    img = snapshot(cam);
    % Write frame to video
    writeVideo(vidWriter,img);
end

%Clean Up:Once the connection is no longer needed, clear the associated variable.
close(vidWriter);
clear cam
videoFile=filename;
end

