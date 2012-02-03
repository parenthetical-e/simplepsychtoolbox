function pavlov_out(params_file,TR),
% Ss learn to associate two II categories seperatly with gains and losses.
%
% Displays a coaster (parameterized in each row pf params_file) 
% followed by a 'Gain $1' or 'Lose $1'. 
%
% IN
%  params_file: a parameter file created by setup_cat_r.m
% 
% Note: to turn on debuging mode set 'dbug' to 1 in this .m file.

	%% USER DEFINITIONS %%
	dbug = 0;
	%% ===========

	offset = 0.5;
	TR_adj = TR - offset;
		%% Decrement TR to allow a gap between stim offsets and ...
		%% ttl_release_INC() calls
	
	[window,screenRect,colors] = screen_init(dbug);
	coords = define_coords(window,screenRect);
	[fid_ttl,ttl_file_name] = create_log(['ttl_' params_file]);
	
	stim_params = load(params_file);	

	write_msg(TR_adj,'Hi. Are you ready?',40,-100,0,window,coords,colors);
	ttl_release_INC(fid_ttl,'WAITING...');
	write_countdown(10,window,coords,colors);

	ttl_release_INC(fid_ttl,'START_LOOP');
	for cnt=1:size(stim_params,1),
		
		log_time(fid_ttl,'*****');
		row = stim_params(cnt,:);
				
		%% Show disc then wait 1 sec and 
		%% display the reward associated with it.
		%% Then wait half a second.
		log_time(fid_ttl,'COASTER');
		paint_coaster(TR_adj*2,row,window,coords,colors);
		%% Use data in row to decide whether to display 
		%% a gain or loss; rt is a dummy variable here.
		rt = 1;
		if row(5) == 1,
			acc = 1;
		elseif row(5) == -1,
			acc = 0;
		end
		
		paint_nothing(offset*2,window,coords,colors);	
			%% Delay
		
		log_time(fid_ttl,'FEEDBACK');
		write_monetary_feedback(TR_adj,acc,rt,1,1,window,coords,colors);
		
		log_time(fid_ttl,'ITI');
		paint_fixation(0,window,coords,colors);
		
		WaitSecs(0.5);
		%ttl_release_INC(fid_ttl,'*** TTL ***');
	end
	screen_close();
end
