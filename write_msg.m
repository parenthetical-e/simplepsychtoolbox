function write_msg(n_sec,msg,fontsize,window,coords,colors),
% Present msg for n_sec in fontsize font
	screen('TextSize', window, size);
	screen('DrawText', window, msg,...
			coords.xc-200, coords.yc-50 ,colors.black);
	Screen('Flip', window);
	Screen('Close');
	WaitSecs(n_sec);
end
