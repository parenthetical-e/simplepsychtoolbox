function paint_nothing(n_sec,window,coords,colors),
	% Paint a grey screen...
	screen('TextSize', window, 26);
	screen('DrawText', window, '', coords.xc, coords.yc ,colors.gray);
	Screen('Flip', window);
	Screen('Close');
	WaitSecs(n_sec);
end
