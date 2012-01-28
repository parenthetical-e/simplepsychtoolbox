function ttl_release_example(),
% An exmple of how to collect TTL pulses at the INC scanner; 
% Display example coasters from the two II categories.
% 
% Note: to turn on debuging mode set 'dbug' to 1 in this .m file.

	%% USER DEFINITIONS %%
	dbug = 1;
	params_file = 'debug_10_pavlov.dat'
	%% =========== 

	%5% Make a Screen
	[window,screenRect,colors] = screen_init(dbug);
	coords = define_coords(window,screenRect)
	
	%% Read in the parameters for the disks
	try,
		stim_params = load(params_file);
	catch err,
		error(['Could not read ' params_file '.']);
		rethrow(err)
	end

	%% Make a file to store the times of the scanner pulses,
	%% just in case something bad happens.
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
	
	% Start trial loop with the
	for cnt=1:size(stim_params,1),
		row = stim_params(cnt,:);

		%% Put a disc on the screen
		paint_coaster(0,row,window,coords,colors);
		
		%% **Micheal: below is what collects from the scanner**
		%%
		%% Wait for the scanner pulse.  Do nothing till it arrives.
		%% NOTE: in case something goes wrong, the time the ttl pulse
		%% happens is stored in the file indicated by fid_ttl.
		ttl_release_INC(fid_ttl,'TTL_DETECTED');
	end
	screen_close();
end
