function write_countdown(n_sec,window,coords,colors),
	%% Print seconds till start...
	for s_cnt=1:n_sec
		s = (n_sec + 1) - s_cnt;

		msg = ['Start in ' num2str(s) ' seconds.'];
		% write_msg(n_sec,msg,fontsize,xoff,yoff,window,coords,colors)
		write_msg(1,msg,30,-150,0,window,coords,colors)
	end
	Screen('Close');
end
