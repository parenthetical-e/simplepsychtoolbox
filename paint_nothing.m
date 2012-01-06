function paint_nothing(n_sec,window,coords,colors),
% Paints nothing (an empty black screen).
%
% [VBLTimestamp onset_time] = paint_nothing(n_sec,window,coords,colors);
%
% IN
%  n_sec: Leave nothing onscreen for this many seconds.
%  window,coords,colors: standard Screen() variables.
%
% OUT
%  VBLTimestamp: ?
%  onset_time: the time in seconds when nothing was intially painted. 

		screen('TextSize', window, 26);
		screen('DrawText', window, '', coords.xc, coords.yc ,colors.black);
		[VBLTimestamp onset_time] = Screen('Flip', window);
		Screen('Close');
		WaitSecs(n_sec);
end
