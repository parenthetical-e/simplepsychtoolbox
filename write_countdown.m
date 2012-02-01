function write_countdown(n_sec,window,coords,colors),
% A counter, writing seconds till start.
%
% write_countdown(n_sec,window,coords,colors);
%
% IN
%  n_sec: length of countdown.
%  window,coords,colors: standard Screen() variables.

	for s_cnt=1:n_sec
		s = (n_sec + 1) - s_cnt;

		msg = ['Start in ' num2str(s) ' seconds.'];
		% write_msg(n_sec,msg,fontsize,xoff,yoff,window,coords,colors)
		write_msg(1,msg,40,-150,0,window,coords,colors)
	end
	Screen('Close');
end
