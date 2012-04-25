function pavlov_cat_r(params_file),
	%% Basic setup
	clc
	close all													
	rand('seed',sum(100*clock))
	warning('off')
	PsychJavaTrouble 
	%Screen('Preference', 'SkipSyncTests',0);

	%% Setup for Screen
	global window screenRect white black grey xc yc meshX meshY ... 
		circlespace stim_pixels visual_angle_in_degrees dist_to_screen_cm

	hideCursor;
	[window,screenRect] = Screen('OpenWindow',0,0);
	priorityLevel=MaxPriority(window);
	Priority(priorityLevel);

	white = WhiteIndex(window);
	black = BlackIndex(window);
	grey = [(white+black)/2 (white+black)/2 (white+black)/2];
	red   = [160 25 29];
	green = [59 174 60];
		% Define colors
	xc = screenRect(3)/2; 
	yc = screenRect(4)/2; 
		% Define center
	
	%% Coaster setup
	visual_angle_in_degrees = 6; 
	dist_to_screen_cm = 76;
	[circlespace,meshX,meshY] = make_circlespace();
		% Make meshX meshY circlespace
	Screen('FillRect', window,grey);
	Screen('Flip', window);
		% Clear screen to grey background:

	%% Seconds till start...
	for s_cnt=1:5
		s = 6-s_cnt;
		Screen('TextSize', window, 50);
		msg = ['Start in ' num2str(s) ' seconds.'];
		Screen('DrawText',window,msg,xc-150,yc-50,black);
		Screen('Flip', window);
		WaitSecs(1);
	end

	%% And start
	try,
		stim_params = load(params_file);
	catch,
		error('Could not read the params_file.');
	end

	for cnt=1:size(stim_params,1),
		row = stim_params(cnt,:);

		% Present cross hair
		screen('TextSize', window, 26);
		screen('DrawText', window, '+', xc, yc ,black);
		Screen('Flip', window);
		WaitSecs(1);
		
		%% Show disc then wait 1 sec and 
		%% display the reward associated
		%% with it.
		showdisc_cat_r(row);
		WaitSecs(1);
		
		%% Feedback delay
		FlushEvents;
		Screen('TextSize', window, 70);
		Screen('DrawText', window, '', xc, yc ,black);
		Screen('Flip', window);
		Screen('Close');
		WaitSecs(0.5);

		%% Prep reward parameters
		if row(5) == 1,
			reward = 'Gain $1';
			reward_color = green;
		elseif row(5) == -1,
			reward = 'Lose $1';
			reward_color = red;
		end
		
		%% Reward onscreen
		FlushEvents;
		Screen('FillRect', window,grey);
		Screen('TextSize', window, 90);
		Screen('DrawText', window, reward, xc-150, yc-50 ,reward_color);
		Screen('Flip', window);
		Screen('Close');
		WaitSecs(.5);
	end
	FlushEvents;
    Screen('CloseAll');
    ShowCursor;
    fclose('all');
    Priority(0);	
end
