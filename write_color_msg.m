function write_color_msg(n_sec,msg,fontsize,color_param,xoff,yoff,window,coords),
% Present msg for n_sec in fontsize font with the text offset by
% xoff and yoff in color color_param (from the colors struct define
% by screen_init().
	screen('TextSize', window, fontsize);
	screen('DrawText', window, msg,...
			coords.xc+xoff, coords.yc+yoff,color_param);
	Screen('Flip', window);
	Screen('Close');
	WaitSecs(n_sec);
end
