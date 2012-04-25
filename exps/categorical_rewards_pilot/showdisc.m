function showDisc(stimulus, stim_type);

global window screenRect white black grey xc yc meshX meshY circlespace correct incorrect wrong_key stim_pixels visual_angle_in_degrees dist_to_screen_cm

x = meshX;
y = meshY;

white=WhiteIndex(window);
black=BlackIndex(window);
gray=(white+black)/2;
if round(gray)==white
	gray=black;
end

inc=white-gray;

%% Present Learning cue
cue_size = 200;
if stim_type == 1
    Screen('FillRect', window, [0 0 75], [xc-cue_size yc-cue_size xc+cue_size yc+cue_size]); % Blue
elseif stim_type == 2
    Screen('FillRect', window, [0 75 0], [xc-cue_size yc-cue_size xc+cue_size yc+cue_size]); % Green
elseif stim_type == 3
    Screen('FillRect', window, [75 0 0], [xc-cue_size yc-cue_size xc+cue_size yc+cue_size]); % Red
end

%% Present Disk
% We use the fact that sin(x) has 1 cycle every 2*pi pixels.  That
% means that sin(k*x) has k cycles every 2*pi pixels.  Using a conversion
% factor of stim_pixels/visual_angle_in_degrees and after doing some
% algebra we see that the following value of k will give produce the
% correct number of cycles per degree.

cycles_per_degree = stimulus(2);
k = (2*pi*visual_angle_in_degrees*cycles_per_degree)/stim_pixels

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
gray+inc*disc
screen('PutImage',window,gray+inc*disc);

% Present Cues
size = 100;
xloc1 = xc - 250 - (.5*size); % left
xloc2 = xc + 300 - (.5*size); % right
yloc = yc + 300;


Screen('TextSize', window, 100);
Screen('DrawText', window, 'A', xloc1,  yloc, black);
Screen('DrawText', window, 'B', xloc2,  yloc, black);

Screen('Flip', window);
