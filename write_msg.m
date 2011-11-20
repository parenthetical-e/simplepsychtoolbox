function write_msg(n_sec,msg,fontsize,xoff,yoff,window,coords,colors),
% Present msg for n_sec in fontsize font with the text offset by
% xoff and yoff
	screen('TextSize', window, fontsize);
	screen('DrawText', window, msg,...
			coords.xc+xoff, coords.yc+yoff,colors.black);
	Screen('Flip', window);
	Screen('Close');
	WaitSecs(n_sec);
end
