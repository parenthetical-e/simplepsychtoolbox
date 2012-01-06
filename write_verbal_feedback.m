function write_verbal_feedback(n_secs,acc,rt,window,coords,colors),
% Writes verbal feedback to the Screen (e.g. 'Correct!').
%
% write_verbal_feedback(n_secs,acc,rt,window,coords,colors);
%
% IN
%  n_secs: how long are the words oncreen (seconds)
%  acc: accuracy, {0,1}
%  rt: Reaction time (seconds; float)
%  window,coords,colors: standard Screen() variables.

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
	write_msg(n_secs,msg,40,-100,0,window,coords,colors);
		% Display feedback in 40 pt font for n_secs
		% if no matches diplay 'Error', which is very 
		% unlikely.
end
