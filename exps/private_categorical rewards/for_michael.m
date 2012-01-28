function for_micheal(),
% An exmple of how to collect TTL pulses at the INC scanner; 
% Displays 10 example disks from the two II categories.
% 
% Note: to turn on debuging mode set 'dbug' to 1 in this .m file.

	%% USER DEFINITIONS %%
	dbug = 1;
	params_file = 'debug_10_pavlov.dat';
	%% =========== 

	%5% Make a Screen
	[window,screenRect,colors] = screen_init(dbug);
	coords = define_coords(window,screenRect)
	
	%% Read in the parameters for the disks
	try,
		stim_params = load(params_file);
	catch err,
		error(['Could not read ' params_file '.']);
		rethrow(err);
	end

	%%%%%%%%%%%%%%%%%%%%%%%%
	%% Start scanner *now* %
	%%%%%%%%%%%%%%%%%%%%%%%%
	
	% Start trial loop with the
	for cnt=1:size(stim_params,1),
		row = stim_params(cnt,:);

		%% Show disc then wait 1 sec
		paint_coaster(1,row,window,coords,colors);
		
		%% Micheal: this is what collects from the scanner
		%% Now wait for the scanner pulse.  Do nothing till it arrives
		ttl_release_INC_get(fid_ttl,'ITI',0);
	end
	screen_close();
end
