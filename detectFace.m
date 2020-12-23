function detectedFaces = detectFace(videoFile)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%% Setup: create Video Reader and Writer
detectedFaces = [];
first25BadFrames = zeros(1,25);
first25GoodFrames = zeros(1,25);
videoFileReader = VideoReader(videoFile);
myVideo = VideoWriter('myLifeCapture.avi');

% Setup: create deployable video player and face detector
depVideoPlayer = vision.DeployableVideoPlayer;
faceDetector = vision.CascadeObjectDetector();
open(myVideo);

% Detect faces in each frame
bad=1;
good =1;
frameNo = 1;
while hasFrame(videoFileReader)
	% read video frame
	videoFrame = readFrame(videoFileReader);
    
	% process frame
    bbox = faceDetector(videoFrame);
   
    videoFrame = insertShape(videoFrame, 'Rectangle', bbox); 
    
	% Display video frame to screen
	depVideoPlayer(videoFrame);
    
     if length(bbox) == 4
        detectedFaces = [detectedFaces bbox];
        if good < 26
            first25GoodFrames(1,good)=frameNo;
        end
        good = good+1;
     else
         if bad < 26
            first25BadFrames(1,bad) = frameNo;
         end
         t = strcat('No face detected in frame: ',num2str(frameNo));
        disp(t)
        bad=bad+1;
    end

	% Write frame to final video file
	writeVideo(myVideo, videoFrame);
	pause(1/videoFileReader.FrameRate);
    frameNo = frameNo+1;
end

%plot first 25 good frames with face detected
for i=1:25 
    subplot(5,5,i)
    imshow(read(videoFileReader,first25GoodFrames(1,i)))
end 
sgtitle('Good:First 25 good frames with faces Detected','Color','green')

%Plot first 25 bad frames with no  face detected.
figure
for i=1:25 
    subplot(5,5,i)
    imshow(read(videoFileReader,first25BadFrames(1,i)))
end 
sgtitle('Bad: First 25 Frames with no faces detected','Color','red')
good = good - 1
bad=bad-1
totalframes = good+bad

detectionaccuracy = good/totalframes

close(myVideo)
% detectedFaces=detectedFaces(1:i-1);
end

