function pavlov(params_file),
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
	dbug = 1;
	%% ===========

	[window,screenRect,colors] = screen_init(dbug);
	coords = define_coords(window,screenRect)
	try,
		stim_params = load(params_file);
	catch,
		error(['Could not read ' params_file '.']);
	end 
	
	write_countdown(5,window,coords,colors);
	for cnt=1:size(stim_params,1),
		row = stim_params(cnt,:);

		paint_fixation(1,window,coords,colors);

		%% Show disc then wait 1 sec and 
		%% display the reward associated with it.
		%% Then wait half a second.
		paint_coaster(1,row,window,coords,colors);
		paint_nothing(0.5,window,coords,colors);
		
		%% Use data in row to decide whether to display 
		%% a gain or loss; rt is a dummy variable here.
		rt = 1;
		if row(5) == 1,
			acc = 1;
		elseif row(5) == -1,
			acc = 0;
		end
		write_monetary_feedback(1,acc,rt,1,1,window,coords,colors);
	end
	screen_close();
end
