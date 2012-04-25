function showdisc_cat_r(stimulus),

global window screenRect white black grey xc yc meshX meshY circlespace stim_pixels visual_angle_in_degrees dist_to_screen_cm

x = meshX;
y = meshY;

white=WhiteIndex(window);
black=BlackIndex(window);
gray=(white+black)/2;
if round(gray)==white
	gray=black;
end

inc=white-gray;
cue_size = 200;
%% Present Disk
% We use the fact that sin(x) has 1 cycle every 2*pi pixels.  That
% means that sin(k*x) has k cycles every 2*pi pixels.  Using a conversion
% factor of stim_pixels/visual_angle_in_degrees and after doing some
% algebra we see that the following value of k will give produce the
% correct number of cycles per degree.

cycles_per_degree = stimulus(2);
k = (2*pi*visual_angle_in_degrees*cycles_per_degree)/stim_pixels;

% Next we use that the gradient of the curve z = sin(theta)*x+cos(theta)*y
% has constant length, meaning that the spatial frequency of sin(k*x) will
% be the same as the spatial frequency of
% sin(k*(sin(theta)*x+cos(theta)*y)) for all values of theta.

orientation_angle = stimulus(3);
g = sind(orientation_angle);
h = cosd(orientation_angle);
wave=sind((g*x+h*y)*k);

% Create image to place on screen

disc = circlespace.*wave
size(disc)
gray+inc

Screen('FillRect', window, gray, ...
		[xc-cue_size yc-cue_size xc+cue_size yc+cue_size]);
screen('PutImage',window,gray+inc*disc);
Screen('Flip', window);
Screen('Close');
