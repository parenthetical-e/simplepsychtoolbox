function create_triallist_SR(sub_code,n_imgs,n_trials),
%% A determinstic 2 response SR task:
%% Create a trial list w/ 2 conditions/responses, with a total 
%% of n_imgs of stimuli with n_trials trials.
%% n_imgs are as evenly as possible divided among the condtions.	

	%% Find all jpgs and randomly grab n_imgs.
	org_dir = pwd();
	cd('./imgs/');
	stims = dir('*.jpg');
	stims_to_use = struct([]);
	use_index = randsample(size(stims,1),n_imgs);
	for cnt=1:size(use_index),
		stims_to_use(cnt).name = stims(use_index(cnt)).name;
	end
	cd(org_dir);
	
	%% Create filename
	f_name = [num2str(sub_code) '_trials.dat'];
	if exist(f_name, 'file'),
		disp(['Deleting ' f_name]);
		delete(f_name);  
	end
	fid = fopen(f_name,'a+');

	%% In the condlist, for trials coded as 1 q is the right answer;
	%% For 1 also randomly map to one of the first ~half the 
	%% stims_to_use; 2 gets the remainder.
	condlist = randsample(2,n_trials,true);
	first_half_index = 1:round(n_imgs/2.);
	back_half_index = (1+round(n_imgs/2.)):n_imgs;
	for cnt=1:size(condlist),
		trl = condlist(cnt);
		if trl == 1,
			%% For each trial/row store the condition, the stim image
			%% name and the correct response.
			fprintf(fid,'%s\t',num2str(trl));
			fprintf(fid,'%s\t',stims_to_use(...
					randsample(first_half_index,1)).name);
			fprintf(fid,'%s\n','q');
		else,
			fprintf(fid,'%s\t',num2str(trl));
			fprintf(fid,'%s\t',stims_to_use(...
					randsample(back_half_index,1)).name);
			fprintf(fid,'%s\n','w');
		end
	end
	fclose(fid);
end
