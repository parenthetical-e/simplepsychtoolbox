function [is_at, crit_vec] = is_at_criterion(datapoint,crit,crit_vec_last,len_crit_vec),
%% Useful for testing for a behavoiral criterion.  Uses a vector of prior
%% data of length len_crit_vec to calculate a mean, which is then compared 
%% to the criterion (crit).  If it meets or exceeds it, the crit flag 
%% 'is_at' becomes one.

	is_at = 0;
		% Default: we are not at criterion
	if length(crit_vec_last) < len_crit_vec,
		crit_vec = [crit_vec_last datapoint]
			% Not long enough, extend.
	else,
		%% Shift the data left once, add datapoint
		%% and test for crit
		crit_vec = [crit_vec_last(2:end) datapoint]
		if mean(crit_vec) > crit,
			is_at = 1;
		end
	end

end
