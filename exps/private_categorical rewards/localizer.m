function localizer(params_file,TR),
% Display example coasters from the two II categories learned in pavlov().
%
% This designed for testing TTL pulse detection at the INC scanner; in 
% practice log_time() is very overused.
%
% IN
%  params_file: a '_pavlov' parameter file created by setup_cat_r.m
% 
% Note: to turn on debuging mode set 'dbug' to 1 in this .m file.
	
	%% USER DEFINITIONS %%
	offset = 0.5;
	TR_adj = TR - offset;
	
	dbug = 0;
	N = 90;
	%% =========== 

	[window,screenRect,colors] = screen_init(dbug);
	coords = define_coords(window,screenRect);
	
	[fid_ttl ttl_file_name] = create_log(['ttl_' params_file]);
		% create ttl logging file

	stim_params = load(params_file);
	jitter_vec = shuffle(repmat([0 0 0 0 0 0 0 0 0 0 1 1 1 2 2 3 4 5],1,5));
		% 190 TRs
	%%%%%%%%%%%%%%%%%%%%%%%%
	%% Start scanner *now* %
	%%%%%%%%%%%%%%%%%%%%%%%%
	write_msg(TR_adj,'Hi. Are you ready?',40,-100,0,window,coords,colors);
	ttl_release_INC(fid_ttl,'WAITING...');
	write_countdown(10,window,coords,colors);

	ttl_release_INC(fid_ttl,'START_LOOP');
	for cnt=1:N,
		row = stim_params(cnt,:);
		
		%% Show disc then wait 1 sec and 
		%% display the reward associated with it.
		%% Then wait half a second.
		log_time(fid_ttl,'COASTER');
		paint_coaster(TR_adj*2,row,window,coords,colors);	
		
		%% Randomly select the jitter time from a uniform
		%% distribution inclusivily spanning 1-6
		log_time(fid_ttl,'JITTER');

		paint_fixation((jitter_vec(cnt)*TR)-offset,window,coords,colors);
		FlushEvents;
		
		% Wait for next TTL, 
		% this is the minumum ITI.
		log_time(fid_ttl,'ITI');		
		paint_fixation(0,window,coords,colors);
		ttl_release_INC(fid_ttl,'*** TTL ***');
		FlushEvents;
	end
	fclose(fid_ttl);
	screen_close();
end
