function write_verbal_feedback(n_secs,acc,rt,window,coords,colors),
	msg = 'Feedback error.';
	if acc,
		msg = 'Correct!';
	elseif rt == 0,
		msg = 'No response detected.';
			% rt is zero *only* when no keypress
			% was detected.
	else,
		msg = 'Incorrect!';
	end
	write_msg(n_secs,msg,50,window,coords,colors);
		% Display feedback in 50 pt font for n_secs
		% if no matches diplay 'Error', which is very 
		% unlikely.
end
