function localizer(params_file,TR),
% Display example coasters from the two II categories learned in pavlov().
%
% IN
%  params_file: a coaster params file, for example ii_stim.dat
%  TR: the TR
% 
% Note: to turn on debuging mode set 'dbug' to 1 in this .m file.
	
	%% USER DEFINITIONS %%
	offset = 0.5;
	TR_adj = TR - offset;
	
	dbug = 0;
	%% =========== 

	[window,screenRect,colors] = screen_init(dbug);
	coords = define_coords(window,screenRect);
	
	[fid_ttl ttl_file_name] = create_log(['ttl_' params_file]);

	stim_params = load(params_file);
	
	%%%%%%%%%%%%%%%%%%%%%%%%
	%% Start scanner *now* %
	%%%%%%%%%%%%%%%%%%%%%%%%
	write_msg(0,'Hi. Are you ready?',40,-100,0,window,coords,colors);
	ttl_release_INC(fid_ttl,'WAITING...');
	write_countdown(10,window,coords,colors);

	ttl_release_INC(fid_ttl,'START_LOOP');
	for cnt=1:size(stim_params,1),
		row = stim_params(cnt,:);
		log_time(fid_ttl,['row:	' num2str(row)]);
		
		% As it was defined in my run of Kao's GA, jitter is in units of
		% 2*TR (TR=1.5).  Make it so.
		if strmatch(num2str(row(1)),'0'),
			log_time(fid_ttl,'JITTER');
			WaitSecs((TR*2)-offset);
			ttl_release_INC(fid_ttl,'*** TTL ***');
			continue;
		end
		
		% Show disc then wait 1 sec and 
		% display the reward associated with it.
		log_time(fid_ttl,'COASTER');
		paint_coaster(TR_adj*2,row,window,coords,colors);	
		
		paint_nothing(offset*2,window,coords,colors);	
			%% Delay
		
		% Wait for next TTL, this is the minumum ITI.
		log_time(fid_ttl,'ITI');		
		paint_fixation(TR_adj,window,coords,colors);
		ttl_release_INC(fid_ttl,'*** TTL ***');
		FlushEvents;
	end
	
	fclose(fid_ttl);
	screen_close();
end
