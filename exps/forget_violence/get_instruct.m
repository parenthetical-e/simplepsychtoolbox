function [instruct counter] = get_instruct(binarray,ii,counter),
	% Randomly pick an instruction
	
	R = 'Remember';
	F = 'Forget';
	
	% For the first iteration there is no past
	% take care of that edge case.
	if ii == 1,
		if binarray(1),
			instruct = R;
		else,
			instruct = F;
		end
		return;
			%% Returns to the caller immediatly
	end
	
	% Compare current to last adjusting the counter upwards
	% if they are the same and reseting it if they are not
	if binarray(ii-1) == binarray(ii),
		counter = counter + 1;
	else
		counter = 0;
	end
	
	% If the counter is less than or equal to three
	% do the normal assignment, i.e. 
	% 1 = Remember
	% 0 = Forget
	if counter <= 3,
		if binarray(ii),
			instruct = R;
		else,
			instruct = F;
		end
	else
		% If it is greater then three do 
		% the opposite and reset the counter.
		if binarray(ii),
			instruct = F;
		else,
			instruct = R;
		end
		counter = 0;
	end
end