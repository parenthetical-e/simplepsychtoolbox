function experiment_template_II(exp_file_name),
% This is an information integration 2 category learning task..
% An image (i.e. b/w sinusoidal grating) is presented for 2 seconds, 
% while waiting for a response.  Verbal feedback is 
% displayed contigent on the response.  Trial order,
% as well as the images to present and the correct reponses
% are stored and read from exp_file_name, whose rows 
% are prepresented serially  See 1_II.dat for format 
% info.  1_II.dat was created with create_triallist_II.m.

% Note: I have found that a complete seperation
% between logic and data for experimental programs to faciliatate
% code reuse and, more importantly, simplfy code understanding;
% it is easier to tell what happens.

% As done here, I recommend one set of code to generate 
% the triallist and one to present and collected responses on 
% that triallist.  These two functions could, of course, easily be 
% combined in a batch script.

	%% USER DEFINITIONS %%
	dbug = 1;
		% Turn it on for useful debugging things
		% where are the images files
	accept_resps = ['q' 'w'];
	max_time = 2;
	%% --------------- %%

	[window,screenRect,colors] = screen_init(dbug);
	% Screen is now up and running.
	% If debug, the Screen will occupy only 
	% the top-left 600 pixels.
	% window is the pointer; screenRect the 
	% monitors [dimensions]; {colors} are Screen
	% compatible [R G B] colors.
	% Default color names: white,gray,int,black,red,green.
	% Access example: colors.black

	[stim_code, par1, par2, unk, corr_resps] = textread(...
			exp_file_name,'%f %f %f %f %s');

	data_file_name = ['data_' exp_file_name]
	if exist(data_file_name, 'file'),
		disp(['Deleting ' data_file_name]);
		delete(data_file_name);
	end
	fid = fopen(data_file_name,'a+');
		% create filehandle

	coords = define_coords(window,screenRect);
		% Find many coordinate parameters needed
		% to draw on Screen, and use paint_coaster(),
		% or whatever else might be needed in the 
		% future. This is designed to served as a 
		% image display parameter catcahall
	
	is_at = 0; 
	crit_vec = [];
		% needed for crierion testing following response
		% detection

	msg = ['Welcome to science time!'];
	write_msg(5,msg,30,-150,0,window,coords,colors);
		% Welcome them in 30 pt font with the text x offset
		% to the left by 150 pixels.
		% Or say something useful instead....
	
	write_countdown(5,window,coords,colors);
		% Display a counter informing Ss the experiment will
		% start in 5 seconds

	tic;
		% needed for break_time, 
		% as it relies on toc.

	%% AND BEGIN THE EXPERIMENT...
	for ii=1:size(stim_code,1),
		coaster_params = [stim_code(ii), par1(ii), par2(ii), unk(ii)];
		corr_resp = corr_resps{ii};

		break_time(60,10,window,coords,colors);
			% Take a 60 second break every ~10 minutes
		
		%%%%%%%%
		%% In total, this controls how long the stimulus appears,
		%% you want paint_image() to have zero n_secs
		%% so responses can be detected (w get_resp())
		%% while the stim is up.
		[VBLTimestamp, onset_time] = paint_coaster(...
				coaster_params,0,window,coords,colors);
		[acc,rt,resp] = get_resp(...
				corr_resp,accept_resps,onset_time,max_time);
					% Waits up to max_time seconds for a response

		%% Controls stim presentation time, once a 
		%% response has been detected, the stim disappears
		dtime = rt;
		if rt == 0,
			dtime = max_time;
				% Correct for the fact rt can be 0
		end
		
		paint_nothing(1,window,coords,colors);
			% Feedbak delay is 1 seconds
		%%%%%%%%

		write_color_feedback(2,acc,rt,window,coords,colors);
			% In 30 pt font, display 'Correct' (in green), 
			% or 'Incorrect' (red) or 'No response detected' 
			% (black) for 2 seconds.
		
		%% Fixation cross for long enough so trials are all
		%% the same length
		paint_fixation((max_time - dtime + 0.5),window,coords,colors);
			% By comparing max_time to rt plus a constant 
			% (so there is a delay when they fail to respond),
			% each trial takes the same time.

		%% Unfortuantly matlab is crap at writing
		%% mixed data types by columm.  We have to 
		%% do this manually....sigh.
		fprintf(fid,'%i\t',ii);
		fprintf(fid,'%f\t',coaster_params);
		fprintf(fid,'%s\t',corr_resp);
		fprintf(fid,'%i\t',acc);
		fprintf(fid,'%f\t',rt);
		fprintf(fid,'%s\n',resp);

		%% FInally test for criterion:
		%% that the last 10 trials had 
		%% a mean of 0.65 or greater.
		[is_at,crit_vec] = is_at_criterion(acc,0.65,crit_vec,10);
			% is_at_criterion(datapoint,crit,crit_vec_last,len_crit_vec)
		if is_at == 1,
			msg = ['You met the learning crierion...good dog!'];
			write_msg(5,msg,30,-150,0,window,coords,colors);

			disp(['Criterion was met, ending cleanly.'])
			screen_close(fid);
			return;
		end
	end
	screen_close(fid);
end
