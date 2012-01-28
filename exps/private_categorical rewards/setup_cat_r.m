function setup_cat_r(sub_code,num_pavlov),
	if num_pavlov > 240,
		disp('num_pavlov can not exceed 240.')
		return
	end

	try,
		stim = textread('ii_stim.dat');
	catch,
		disp('Could not open of find ii_stim.dat')
	end

	map_1_2_to_reward = randsample(2,2);
	r_plus = map_1_2_to_reward(1);
	r_minus = map_1_2_to_reward(2);

	rand_rows = randperm(600);
	pavlov_rows = rand_rows(1:num_pavlov);
	cat_rows = rand_rows(num_pavlov+1:end);
	
	%% Create the pavlov file
	f_name = [num2str(sub_code) '_' num2str(num_pavlov) '_pavlov.dat'];
	if exist(f_name, 'file'),
		delete(f_name);  
		disp(['Deleting ' f_name]);
	end
	fid = fopen(f_name,'a+');

	for row_cnt=pavlov_rows,
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

	%% Create the correct/incorrect (1/0)
	%% files for category training.
	f_name_0 =  [num2str(sub_code) '_' num2str(num_pavlov) '_cat_0.dat'];
	f_name_1 =  [num2str(sub_code) '_' num2str(num_pavlov) '_cat_1.dat'];
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

	%% Create the trial list w/ 6 conds, 30 trials per
	%% Find all tree stim and randomly grab 6.
	org_dir = pwd();
	cd('./allMedia/');
	stims = dir('tree*.jpg');
	stims_to_use = struct([]);
	use_index = randsample(size(stims,1),6)
	for cnt=1:size(use_index),
		stims_to_use(cnt).name = stims(use_index(cnt)).name;
	end
	cd(org_dir);
	
	f_name = [num2str(sub_code) '_trials.dat'];
	if exist(f_name, 'file'),
		disp(['Deleting ' f_name]);
		delete(f_name);  
	end
	fid = fopen(f_name,'a+');

	%% Trials coded as 1, q is the right answer,
	%% so randomly map to one of the first 3 stims.
	triallist = randsample(2,180,true);
	for cnt=1:size(triallist),
		tr = triallist(cnt);
		if tr == 1,
			fprintf(fid,'%s\t',stims_to_use(randsample(1:3,1)).name);
			fprintf(fid,'%s\n','q');
		else,
			fprintf(fid,'%s\t',stims_to_use(randsample(4:6,1)).name);
			fprintf(fid,'%s\n','w');
		end
	end
	fclose(fid);
end
