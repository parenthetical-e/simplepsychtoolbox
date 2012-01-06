function write_msg(n_sec,msg,fontsize,xoff,yoff,window,coords,colors),
% Write a message on Screen.
%
% write_msg(n_sec,msg,fontsize,xoff,yoff,window,coords,color_param);
% 
% IN
%  n_sec: time to display in seconds.
%  msg: what to write (a character array, e.g. ['Hello World']).
%  fontsize: ...
%  xoff: x offset in pixels
%  yoff: y offset in pixels
%  window,coords,colors: standard Screen() variables.


	screen('TextSize', window, fontsize);
	screen('DrawText', window, msg,...
			coords.xc+xoff, coords.yc+yoff,colors.black);
	Screen('Flip', window);
	Screen('Close');
	WaitSecs(n_sec);
end
