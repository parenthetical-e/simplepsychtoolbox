function paint_nothing(n_sec,window,coords,colors),
		% Present cross hair for n_sec
		screen('TextSize', window, 26);
		screen('DrawText', window, '', coords.xc, coords.yc ,colors.black);
		Screen('Flip', window);
		Screen('Close');
		WaitSecs(n_sec);
end
