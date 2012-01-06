function [VBLTimestamp onset_time] = paint_image(n_secs,img_name,images_data,window,coords,colors),
% Paints an image on the Screen (e.g. moocow.jpeg).
% 
% [VBLTimestamp onset_time] = paint_image(n_secs,img_name,images_data,window,coords,colors);
%
% IN
%  n_sec: how long in seconds it is onscreen.
%  img_name: the name of the image
%  images_data: the image data, from preload_images().
%  window,coords,colors: standard Screen() variables.
% 
% OUT
%  VBLTimestamp: ?
%  onset_time: the time in seconds when the image was intially painted.

	stim = Screen('MakeTexture', window,...
			images_data.(genvarname(img_name)));
	Screen('DrawTexture', window, stim);
		% draw texture image to backbuffer. it will be automatically
		% centered in the middle of the display if you don't specify a
		% different destination:

	[VBLTimestamp onset_time]=Screen('Flip', window);
	WaitSecs(n_secs);
	Screen('Close');
