function break_time(n_sec,interval,window,coords,colors),
% Every interval (in minutes) a n_sec break is taken.  
% 
% break_time(n_sec,interval,window,coords,colors);
%
% This code is independent of any trial counter but does require
% tic bieng called once prior to its use. See experiment_template_SR.m 
% for real life use example.
% 
% IN
%  n_sec: time to display in seconds
%  interval: how long break should last, in *minutes*.
%  window,coords,colors: standard Screen() variables.

	if (toc/60) > interval,
		msg = 'Break time!  The break is over when the timer reaches 0.';
		write_msg(5,msg,14,-200,0,window,coords,colors);
			% Give them 5 seconds to to read it....
		write_countdown(n_sec,window,coords,colors);
		tic 
			% resets toc
	end
end
