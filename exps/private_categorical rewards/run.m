function run(trial_file,file_0,file_1,TR),
	%% USER DEFINITIONS %%
	offset = 0.5;
	TR_adj = TR - offset;
	dbug = 0;
		% Turn it on for useful debugging things
		% where are the images files
	img_dir = './imgs/';
	accept_resps = ['4' '6'];
	%% --------------- %%	

	
	% Feedback params, right (1) and wrong (0).
	[trialset, correct_resps, is_intervals, it_intervals] = textread(...
			trial_file,'%s %s %u %u');
	cat_0 = load(file_0);
	cat_1 = load(file_1);

	% Init screen
	[window screenRect colors] = screen_init(dbug);
	coords = define_coords(window,screenRect);

	% Create the outging the data files
	[fid_d data_file_name] = create_log(['data_' trial_file]);
	[fid_ttl ttl_file_name] = create_log(['ttl_' trial_file]);
	
	% Preload the tree images
	images_data = preload_images(img_dir);

	%% Create iterators to track the last used row
	%% for the two feedback files
	cnt_right = 1;
	cnt_wrong = 1;

	%%%%%%%%%%%%%%%%%%%%%%%%
	%% Start scanner *now* %
	%%%%%%%%%%%%%%%%%%%%%%%%
	write_msg(TR_adj,'Hi. Are you ready?',40,-100,0,window,coords,colors);
	ttl_release_INC(fid_ttl,'WAITING...');
	write_countdown(10,window,coords,colors);

	% Go trial loop!
	ttl_release_INC(fid_ttl,'START_LOOP');
	for ii=1:size(trialset,1),
		FlushEvents;
		img_name = trialset{ii}
		corr_resp = correct_resps{ii}
		
		% Test for jitter trials, leaving up the fixation
		% if true.
		if strmatch(img_name,'0'),
			log_time(fid_ttl,'JITTER');
			paint_fixation(TR_adj,window,coords,colors);
			ttl_release_INC(fid_ttl,'*** TTL ***');
			continue;
		end
			
		% Put up a tree stimulus. Wait 2* TR_adj for a response
		FlushEvents;
		log_time(fid_ttl,'TREE');
		[VBLTimestamp, onset_time] = paint_image(...
				0,img_name,images_data,window,coords,colors);
		[acc,rt,resp] = get_resp_INC(...
				corr_resp,accept_resps,onset_time,TR_adj*2);
		FlushEvents;
		
		% Feedback delay (2*offset)
		log_time(fid_ttl,'FEEDBACK_DELAY');		
		paint_nothing(offset*2,window,coords,colors);
		FlushEvents;
		
		% Display feedback.
		log_time(fid_ttl,'FEEDBACK');		
		if acc,
			cat_1(cnt_right,:);
			paint_coaster(TR_adj,cat_1(cnt_right,:),window,coords,colors);
			cnt_right = cnt_right + 1;
		elseif rt > 0.001 && ~acc,
			cat_0(cnt_wrong,:);
			paint_coaster(TR_adj,cat_0(cnt_wrong,:),window,coords,colors);
			cnt_wrong = cnt_wrong + 1;
		else,
			write_msg(TR_adj,'No response detected.',40,-100,0,window,coords,colors);
		end
		FlushEvents;
		
		% Write out this trial's data..
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
		
		% Wait for next TTL, 
		% this is the minumum ITI.
		log_time(fid_ttl,'ITI');		
		paint_fixation(0,window,coords,colors);
		ttl_release_INC(fid_ttl,'*** TTL ***');
	end
	fclose(fid_d);
	fclose(fid_ttl);
	screen_close();
end
