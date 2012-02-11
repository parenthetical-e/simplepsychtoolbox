function create_run_files(sub_code,num_pavlov),
	if num_pavlov > 240,
		disp('num_pavlov can not exceed 240.')
		return
	end

	stim = textread('ii_stim.dat');

	map_1_2_to_reward = randsample(2,2);
	r_plus = map_1_2_to_reward(1);
	r_minus = map_1_2_to_reward(2);

	rand_rows = randperm(600);
	pavlov_rows_A = rand_rows(1:(num_pavlov-54));
	pavlov_rows_B = rand_rows((num_pavlov-54)+1:num_pavlov);
		% use the localizer_trial_order for part B of pavlov
		% category conditioning.  as such % neds to contian just 54 events
		
	% CREATE THE PAVLOV FILE A
	f_name_A = [num2str(sub_code) '_' num2str(num_pavlov-54) '_pavlov_A.dat'];
	if exist(f_name_A, 'file'),
		delete(f_name_A);  
		disp(['Deleting ' f_name_A]);
	end
	fid = fopen(f_name_A,'a+');

	for row_cnt=pavlov_rows_A,
		row = stim(row_cnt,:);
		if row(1) == r_plus,
			fprintf(fid,'%f\t',row(1:4));
			fprintf(fid,'%i\n',1);
		elseif row(1) == r_minus,
			fprintf(fid,'%f\t',row(1:4));
			fprintf(fid,'%i\n',-1);
		end
	end
	fclose(fid);
	
	
	% CREATE THE PAVLOV FILE B
	f_name_B = [num2str(sub_code) '_' num2str(54) '_pavlov_B.dat'];
	if exist(f_name_B, 'file'),
		delete(f_name_B);  
		disp(['Deleting ' f_name_B]);
	end
	fid = fopen(f_name_B,'a+');
	
	pavlov_B_trial_order = [2 1 1 0 0 0 2 2 2 1 1 1 1 0 0 2 2 1 1 1 0 0 0 0 0 0 2 1 2 2 2 2 0 1 2 0 0 0 0 0 1 1 1 1 1 1 2 0 0 0 0 1 1 2 2 2 0 0 0 0 0 0 1 0 2 2 2 2 2 0 0 0 1 1 2 1 1 1 1 0 2 2 2 2 1 0 0 0 0 2];
	pavlov_cnt = 0;
	for trl=pavlov_B_trial_order,
		if trl == 0,
			fprintf(fid,'%u\t',[0 0 0 0]);
			fprintf(fid,'%u\n',0);
			continue;
		end
		
		pavlov_cnt = pavlov_cnt + 1;
		row_cnt = pavlov_rows_B(pavlov_cnt);
		row = stim(row_cnt,:);
		if row(1) == r_plus,
			fprintf(fid,'%f\t',row(1:4));
			fprintf(fid,'%i\n',1);
		elseif row(1) == r_minus,
			fprintf(fid,'%f\t',row(1:4));
			fprintf(fid,'%i\n',-1);
		end
	end
	fclose(fid);
	
	
	% CREATE CAT_REWARD_RUN_FILES
	% Create the correct/incorrect (1/0)
	% files for category training.
	cat_rows = rand_rows(num_pavlov+1:end);
	f_name_0 =  [num2str(sub_code) ...
	 	'_' num2str(num_pavlov)  '_run_trials_reward_cat_0.dat'];
	f_name_1 =  [num2str(sub_code) ...
	 	'_' num2str(num_pavlov) '_run_trials_reward_cat_1.dat'];
	if exist(f_name_0, 'file'),
		delete(f_name_0);
		disp(['Deleting ' f_name_0]);
	end
	if exist(f_name_1, 'file'),
		delete(f_name_1);
		disp(['Deleting ' f_name_1]);
	end
	fid0 = fopen(f_name_0,'a+');
	fid1 = fopen(f_name_1,'a+');
	for row_cnt=cat_rows,
		row = stim(row_cnt,:);
		if row(1) == r_plus,
			fprintf(fid1,'%f\t',row(1:4));
			fprintf(fid1,'%i\n',1);
		elseif row(1) == r_minus,
			fprintf(fid0,'%f\t',row(1:4));
			fprintf(fid0,'%i\n',-1);
		end
	end
	fclose(fid0);
	fclose(fid1);

	
	% CREATE RUN_FILES
	% Create the trial list w/ 6 conds, 30 trials per
	% Find all tree stim and randomly grab 6.
	org_dir = pwd();
	cd('./imgs/');
	stims = dir('tree*.jpg');
	stims_to_use = struct([]);
	use_index = randsample(size(stims,1),6)
	for cnt=1:size(use_index),
		stims_to_use(cnt).name = stims(use_index(cnt)).name;
	end
	cd(org_dir);
	
	f_name_A = [num2str(sub_code) '_run_trials_A.dat'];
	if exist(f_name_A, 'file'),
		disp(['Deleting ' f_name_A]);
		delete(f_name_A);  
	end
	fid_A = fopen(f_name_A,'a+');
	
	f_name_B = [num2str(sub_code) '_run_trials_B.dat'];
	if exist(f_name_B, 'file'),
		disp(['Deleting ' f_name_B]);
		delete(f_name_B);  
	end
	fid_B = fopen(f_name_B,'a+');
	
	triallist = [1 1 4 4 6 0 4 2 4 1 0 0 0 0 5 4 5 1 5 5 3 6 6 0 0 2 2 3 3 1 3 2 4 2 2 6 0 5 3 1 2 2 0 4 3 0 0 6 5 6 6 5 1 0 0 5 5 2 2 6 2 0 0 0 6 6 5 0 0 0 0 4 6 4 5 6 4 0 0 0 0 3 3 4 2 5 5 1 0 3 3 1 1 0 6 1 5 3 3 0 4 6 0 0 0 1 2 2 0 5 0 4 4 4 3 3 2 0 1 0 0 0 4 4 0 0 2 1 6 6 2 4 4 1 1 1 5 4 0 6 0 3 3 5 5 4 2 1 1 1 6 1 1 0 2 0 0 6 5 6 0 3 4 3 3 6 4 0 6 6 6 1 1 3 6 3 0 5 5 3 0 0 0 2 2 2 3 2 6 3 5 5 0 1 0 2 5 2 4 1 4 4 4 0 5 5 6 0 3 4 0 5 0 0 6 1 3 5 0 3 0 0 1 6 3 0 2 2 0 5 5 2 5 0 1 4 1 2 0 0 3 0 0 1 3 2 1 4 0 3 5 0 0 4 0 5 2 6 6 2 1 6 0 2 3 3 6 4 4 2];
	%% List was created with Kao's GA.  DO NOT ALTER.
	
	response_assign = randsample([1 6],2);	
	for cnt=1:size(triallist,2)/2,
		tr = triallist(cnt);
		if tr == 0,
			fprintf(fid_A,'%s\t','0');
			fprintf(fid_A,'%s\n','0');
		elseif tr <= 3,
			fprintf(fid_A,'%s\t',stims_to_use(tr).name);
			fprintf(fid_A,'%s\n',num2str(response_assign(1)));
		else,
			fprintf(fid_A,'%s\t',stims_to_use(tr).name);
			fprintf(fid_A,'%s\n',num2str(response_assign(2)));
		end
	end
	for cnt=(size(triallist,2)/2)+1:size(triallist,2),
		tr = triallist(cnt);
		if tr == 0,
			fprintf(fid_B,'%s\t','0');
			fprintf(fid_B,'%s\n','0');
		elseif tr <= 3,
			fprintf(fid_B,'%s\t',stims_to_use(tr).name);
			fprintf(fid_B,'%s\n',num2str(response_assign(1)));
		else,
			fprintf(fid_B,'%s\t',stims_to_use(tr).name);
			fprintf(fid_B,'%s\n',num2str(response_assign(2)));
		end	
	end
	fclose(fid_A);
	fclose(fid_B);
	
	
	% CREATE LOCALIZER FILE
	N = 27 + 27; 
		%% n_1 and N_2 are each 27
		%% localizer_trial_order requite N = 54

	localizer_trial_order = [2 1 1 0 0 0 2 2 2 1 1 1 1 0 0 2 2 1 1 1 0 0 0 0 0 0 2 1 2 2 2 2 0 1 2 0 0 0 0 0 1 1 1 1 1 1 2 0 0 0 0 1 1 2 2 2 0 0 0 0 0 0 1 0 2 2 2 2 2 0 0 0 1 1 2 1 1 1 1 0 2 2 2 2 1 0 0 0 0 2];
		%% List was created with Kao's GA.  DO NOT ALTER

	f_name = [num2str(sub_code) '_' num2str(N) '_localizer.dat'];
	if exist(f_name, 'file'),
		disp(['Deleting ' f_name]);
		delete(f_name);  
	end
	fid_local = fopen(f_name,'a+');
	
	coaster_params_1 = load('ii_stim_1.dat');
	coaster_params_2 = load('ii_stim_2.dat');
	
	rand_index = randperm(size(coaster_params_1,1));
	coaster_params_1 = coaster_params_1(rand_index,:);
	
	rand_index = randperm(size(coaster_params_2,1));
	coaster_params_2 = coaster_params_2(rand_index,:);
	
	for cnt=1:size(localizer_trial_order,2),
		trl = localizer_trial_order(cnt)
		if trl == 1,
			row = coaster_params_1(cnt,:);
		elseif trl == 2,
			row = coaster_params_2(cnt,:);
		else,
			row = [0 0 0 0];
		end
		fprintf(fid_local,'%s\n',num2str(row(1:4)));
	end
end
