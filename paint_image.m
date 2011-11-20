function [VBLTimestamp onset_time] = paint_image(img_name,images_data,window,coords,colors),

	stim = Screen('MakeTexture', window,...
			images_data.(genvarname(img_name)));
	Screen('DrawTexture', window, stim);
		% draw texture image to backbuffer. it will be automatically
		% centered in the middle of the display if you don't specify a
		% different destination:

	[VBLTimestamp onset_time]=Screen('Flip', window);
	Screen('Close')
