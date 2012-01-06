function write_color_msg(n_sec,msg,fontsize,xoff,yoff,window,coords,color_param),
% Write a colored message on Screen.
%
% write_color_msg(n_sec,msg,fontsize,xoff,yoff,window,coords,color_param);
% 
% IN
%  n_sec: time to display in seconds.
%  msg: what to write (a character array, e.g. ['Hello World']).
%  fontsize: ...
%  xoff: x offset in pixels
%  yoff: y offset in pixels
%  window,coords: standard Screen() variables.
%  color_param: the color of the message (from colors).

	Screen('TextSize', window, fontsize);
	Screen('DrawText', window, msg,...
			coords.xc+xoff, coords.yc+yoff,color_param);
	Screen('Flip', window);
	Screen('Close');
	WaitSecs(n_sec);
end
