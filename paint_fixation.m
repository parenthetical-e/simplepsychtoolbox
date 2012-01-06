function [VBLTimestamp onset_time] = paint_fixation(n_sec,window,coords,colors),
% Paints a fixation cross on the Screen.
%
% [VBLTimestamp onset_time] = paint_fixation(n_sec,window,coords,colors),
% 
% IN
%  n_sec: time in secods to paint the cross
%  window,coords,colors: standard Screen() variables. 
%
% OUT
%  VBLTimestamp: ?
%  onset_time: the time in seconds when the cross was initially painted.

		screen('TextSize', window, 26);
		screen('DrawText', window, '+', coords.xc, coords.yc ,colors.black);
		[VBLTimestamp onset_time] = Screen('Flip', window);
		Screen('Close');
		WaitSecs(n_sec);
end
