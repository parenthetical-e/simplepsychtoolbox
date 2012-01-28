function create_triallist_II(sub_code,n_trials),
%% Creaet a trialist for  determinstic 2 category II task

	if n_trials > 600,
		error('n_trials must be less then 600.');
	end

	try,
		stim_params = load('ii_stim.dat');
		stim_params = stim_params(randperm(600),:);
			% Read in the ii data then randomize 
			% the order of the row.  Assume there are
			% 600 rows, there should be.
	catch,
		disp('Could not open or randomize ii_stim.dat');
	end

	%% Randomly map from stim code (in ii_stim.dat)
	%% to response 'w' or 'q'
	map_cat_code = randsample(2,2);
	resp_code = {};
	resp_code.q = map_cat_code(1);
	resp_code.w = map_cat_code(2);

	%% Create filename
	f_name = [num2str(sub_code), '_II.dat'];
	if exist(f_name, 'file'),
		disp(['Deleting ', f_name]);
		delete(f_name);  
	end
	fid = fopen(f_name,'a+');

	%% Create a random list of 2 condtions,
	%% use that to build trial parameter list.
	%% The first entry of each rom is the stim code
	%% test it against resp_code.
	for ii=1:n_trials,
		row = stim_params(ii,:);
		if row(1) == resp_code.q,
			fprintf(fid,'%f\t',row(1:4));
			fprintf(fid,'%s\n','q');
		elseif row(1) == resp_code.w,
			fprintf(fid,'%f\t',row(1:4));
			fprintf(fid,'%s\n','w');
		else,
			error(['Unknown stim condition: ', num2str(row(1))]);
		end
	end
	fclose(fid);
end
