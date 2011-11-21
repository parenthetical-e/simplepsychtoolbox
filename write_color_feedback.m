function write_color_feedback(n_secs,acc,rt,window,coords,colors),
	msg = 'Feedback error.';
	col = colors.black;
	if acc,
		msg = 'Correct!';
		col = colors.green;
	elseif rt == 0,
		msg = 'No response detected.';
		col = colors.black;
			% rt is zero *only* when no keypress
			% was detected.
	else,
		msg = 'Incorrect!';
		col = colors.red;
	end
	write_color_msg(n_secs,msg,40,col,-100,0,window,coords);
		% Display feedback in 30 pt font for n_secs
		% if no matches diplay 'Error', which is very 
		% unlikely.
end
