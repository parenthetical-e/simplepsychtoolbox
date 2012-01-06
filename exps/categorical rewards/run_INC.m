function run_INC(trial_file,file_0,file_1),
	%% USER DEFINITIONS %%
	dbug = 1;
		% Turn it on for useful debugging things
		% where are the images files
	img_dir = './imgs/';
	accept_resps = ['q' 'w'];
	max_time = 3;
	%% --------------- %%	

	%% Right (1) and wrong (0) 
	%% feedback stimulus params
	%	trialset = read(trial_file);
	try,
		[trialset, correct_resps, is_intervals, it_intervals] = textread(...
				trial_file,'%s %s %u %u');
		cat_0 = load(file_0);
		cat_1 = load(file_1);
	catch,
		error('Could not load one of the files.');
	end

	[window,screenRect,colors] = screen_init(dbug);
	coords = define_coords(window,screenRect);

	images_data = preload_images(img_dir);

	%% Create the outging the data file
	data_file_name = ['data_' trial_file]
	if exist(data_file_name, 'file'),
		disp(['Deleting ' data_file_name]);
		delete(data_file_name);
	end
	fid_d = fopen(data_file_name,'a+');
		% create data filehandle

	ttl_file_name = ['ttl_' trial_file]
	if exist(ttl_file_name, 'file'),
		disp(['Deleting ' ttl_file_name]);
		delete(ttl_file_name);
	end
	fid_ttl = fopen(ttl_file_name,'a+');
		% create ttl logging file
	
	%% Create iterators to track the last used row
	%% for the two feedback files
	cnt_right = 1;
	cnt_wrong = 1;

	%%%%%%%%%%%%%%%%%%%%%%%%
	%% Start scanner *now* %
	%%%%%%%%%%%%%%%%%%%%%%%%
	write_countdown(10,window,coords,colors);
	ttl_release_INC(4,fid_ttl,'START',0);
		% Give the tech 10 seconds to hit go.
		% 4 second buffer after, we will never use TRs
		% longer than this.

	%% Go trial loop!
	for ii=1:size(trialset,1),
		img_name = trialset{ii};
		corr_resp = correct_resps{ii};
		iti = it_intervals{ii};
		isi = is_intervals{ii};
		
		%% In total, this controls how long the stimulus appears,
		%% you want paint_image() to have zero n_secs
		%% so responses can be detected (w get_resp())
		%% while the stim is up.
		[VBLTimestamp, onset_time] = paint_image(...
				0,img_name,images_data,window,coords,colors);
		[acc,rt,resp] = get_resp(...
				corr_resp,accept_resps,onset_time,max_time);
					% Waits up to max_time seconds for a response
		
		%% Feedback delay
		paint_nothing(isi-0.5,window,coords,colors);
		ttl_release_INC(0.5,fid_ttl,'ISI',0);
	
		if acc,
			cat_1(cnt_right,:);
			paint_coaster(1,cat_1(cnt_right,:),window,coords,colors);
			cnt_right = cnt_right + 1;
		elseif rt > 0.001 && ~acc,
			cat_0(cnt_wrong,:);
			paint_coaster(1,cat_0(cnt_wrong,:),window,coords,colors);
			cnt_wrong = cnt_wrong + 1;
		else,
			write_msg(1,'No response detected.',40,-100,0,window,coords,colors);
		end
		FlushEvents;
		
		%% Write out this trial's data..
		fprintf(fid_d,'%i\t',ii);
		fprintf(fid_d,'%s\t',trialset{ii})
		fprintf(fid_d,'%s\t',correct_resps{ii})
		fprintf(fid_d,'%i\t',acc);
		fprintf(fid_d,'%f\t',rt);
		fprintf(fid_d,'%s\t',resp);
		if acc,
			fprintf(fid_d,'%f\t',cat_1(cnt_right-1,:));
			fprintf(fid_d,'%s\n','');
		elseif rt > 0.001 && ~acc,
			fprintf(fid_d,'%f\t',cat_0(cnt_wrong-1,:));
			fprintf(fid_d,'%s\n','');
		else,
			fprintf(fid_d,'%f\t',[0 0 0 0 0])
			fprintf(fid_d,'%s\n','')
		end

		% ITI / fixation, keeping trial lengths the same.
		time_left = max_time - rt;
		paint_fixation((iti + time_left - 0.5),window,coords,colors);
		ttl_release_INC(0.5,fid_ttl,'ITI',0);
	end
	fclose(fid_d);
	fclose(fid_ttl);
	screen_close();
end
