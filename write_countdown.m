function write_countdown(n_sec,window,coords,colors),
	%% Print seconds till start...
	for s_cnt=1:n_sec
		s = (n_sec + 1) - s_cnt;
		Screen('TextSize', window, 50);
		msg = ['Start in ' num2str(s) ' seconds.'];
		Screen('DrawText', ...
				window,msg,coords.xc-150,coords.yc-50,colors.black);
		Screen('Flip', window);
		WaitSecs(1);
	end
	Screen('Close');
end
