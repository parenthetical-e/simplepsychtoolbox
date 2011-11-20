function break_time(n_sec,interval,window,coords,colors),
%% Every interval (in minutes) a n_sec break is taken.  Note:
%% this code is independent of any trial counter but does require
%% tic bieng called once prior to its use. 
%% See experiment_template_SR.m for an example.

	if (toc/60) > interval,
		msg = 'Break time!  The break is over when the timer reaches 0.';
		write_msg(5,msg,14,0,0,window,coords,colors)
			% Give them 5 seconds to to read it....
		write_countdown(n_sec,window,coords,colors)
		tic 
			% resets toc
	end
end
