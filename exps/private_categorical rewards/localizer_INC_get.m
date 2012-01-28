function localizer(params_file),
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
	dbug = 1;
	%% =========== 

	[window,screenRect,colors] = screen_init(dbug);
	coords = define_coords(window,screenRect)
	try,
		stim_params = load(params_file);
	catch,
		error(['Could not read ' params_file '.']);
	end

	ttl_file_name = ['ttl_' params_file]
	if exist(ttl_file_name, 'file'),
		disp(['Deleting ' ttl_file_name]);
		delete(ttl_file_name);
	end
	fid_ttl = fopen(ttl_file_name,'a+');
		% create ttl logging file

	%%%%%%%%%%%%%%%%%%%%%%%%
	%% Start scanner *now* %
	%%%%%%%%%%%%%%%%%%%%%%%%
	log_time(fid_ttl,'Countdown.');
	write_countdown(10,window,coords,colors);
	ttl_release_INC_get(6,fid_ttl,'START',0);
		% Give the tech 10 seconds to hit go.
		% 4 second buffer after, we will never use TRs
		% longer than this.

	for cnt=1:size(stim_params,1),
		log_time(fid_ttl,num2str(cnt));
		row = stim_params(cnt,:);

		%% Show disc then wait 1 sec and 
		%% display the reward associated with it.
		%% Then wait half a second.
		log_time(fid_ttl,'coaster_on');
		paint_coaster(1,row,window,coords,colors);	
		log_time(fid_ttl,'coaster_off');
		
		%% Randomly select the jitter time from a uniform
		%% distribution inclusivily spanning 1-6
		log_time(fid_ttl,'jitter_on');
		jitter = 1;
		paint_fixation(jitter-0.5,window,coords,colors);
		log_time(fid_ttl,'jitter_off');

		log_time(fid_ttl,'ttl_wait');
		ttl_release_INC_get(5,fid_ttl,'ITI',0);
		log_time(fid_ttl,'ttl_hit');
	end
	log_time(fid_ttl,'STOP');
	screen_close();
end
