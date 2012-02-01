function write_monetary_feedback(n_secs,acc,rt,gain,lose,window,coords,colors),
% Writes color coded monetary feedback to the Screen (e.g. 'Gain $1', in green).
%
% write_monetary_feedback(n_secs,acc,rt,gain,lose,window,coords,colors);
%
% IN
%  n_secs: how long are the words oncreen (seconds)
%  acc: accuracy, {0,1}
%  rt: Reaction time (seconds; float)
%  gain: amount for wins (float)
%  lose: amount for losses (float)
%  window,coords,colors: standard Screen() variables.


	msg = 'Feedback error.';
	col = colors.black;
	if acc,
		msg = ['Gain $', num2str(gain)];
		col = colors.green;
	elseif rt == 0,
		msg = 'No response detected.';
		col = colors.black;
			% rt is zero *only* when no keypress
			% was detected.
	else,
		msg = ['Lose $', num2str(lose)];
		col = colors.red;
	end
	write_color_msg(n_secs,msg,40,-100,0,window,coords,col);
		% Display feedback in 30 pt font for n_secs
		% if no matches diplay 'Error', which is very 
		% unlikely.
end
