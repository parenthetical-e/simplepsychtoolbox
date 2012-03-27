function [is_at crit_vec] = is_at_criterion(datapoint,crit,crit_vec_last,len),
% Uses the mean of a vector of current and past data to test for a criterion.
% 
% [is_at, crit_vec] = is_at_criterion(datapoint,crit,crit_vec_last,len),
% 
% IN
%  datapoint: data from the current trial you want to test
%  crit: the criterion
%  crit_vec_last: past datapoints, in an array
%  len: the length of crit_vec_last, how much of the past is remembered
%
% OUT
%  is_at: if crit is exceeded this becomes one (was 0); it is a flag.
%  crit_vec: the updated crit_vec_last for use on next trial.

	is_at = 0;
		%% Default: we are not at criterion
	if length(crit_vec_last) < len_crit_vec,
		crit_vec = [crit_vec_last datapoint];
			%% Not long enough, extend.
	else,
		% Shift the data left once, add datapoint
		% and test for crit
		crit_vec = [crit_vec_last(2:end) datapoint]
		if mean(crit_vec) > crit,
			is_at = 1;
		end
	end

end
