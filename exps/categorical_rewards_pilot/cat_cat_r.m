function cat_cat_r(trial_file,file_0,file_1),
	%% Basic setup
	clc
	close all													
	rand('seed',sum(100*clock))
	warning('off')
	PsychJavaTrouble 
	%Screen('Preference', 'SkipSyncTests',0);
	disp('***********************')

	acceptableResponses = ['q' 'w'];
	maxRespLength = 2;	
	
	%% Right (1) and wrong (0) 
	%% feedback stimulus params
	%	trialset = read(trial_file);
	try,
		[trialset, correct_resps] = textread(trial_file,'%s %s');
		cat_0 = load(file_0);
		cat_1 = load(file_1);
	catch,
		error('Could not load one of the files.');
	end

	%% Setup for Screen
	global window screenRect white black grey xc yc meshX meshY ... 
		circlespace stim_pixels visual_angle_in_degrees dist_to_screen_cm
	
	hideCursor;
	priorityLevel=MaxPriority(window);
	Priority(priorityLevel);
	[window,screenRect] = Screen('OpenWindow',0,0);
	white = WhiteIndex(window);
	black = BlackIndex(window);
	grey = [(white+black)/2 (white+black)/2 (white+black)/2];
	red = [160 25 29];
	green = [59 174 60];
		%% Define colors
	xc = screenRect(3)/2; 
	yc = screenRect(4)/2; 
		%% Define center
	Screen('FillRect', window,grey);
	Screen('Flip', window);
		% Clear screen to grey background

	visual_angle_in_degrees = 6; 
	dist_to_screen_cm = 76;
	[circlespace,meshX,meshY] = make_circlespace();
		% Make meshX meshY circlespace

	%% Preload the category stimuli
	imgsToImport = unique(trialset);
	for cnt=1:size(imgsToImport,1),
		imgpath = strcat('./allMedia/', imgsToImport{cnt});
		imdata=imread(imgpath,'jpg');
		imgHash.(genvarname(imgsToImport{cnt})) = imdata;
	end

	%% Open the data file
	f_name = ['data_' trial_file];
	if exist(f_name, 'file'),
		disp(['Deleting ' f_name]);
		delete(f_name);  
	end
	fid = fopen(f_name,'a+');

	%% Create iterators for the two feedback files
	cnt_right = 1;
	cnt_wrong = 1;

	%% Seconds till start...
	for s_cnt=1:5
		s = 6-s_cnt;
		Screen('TextSize', window, 50);
		msg = ['Start in ' num2str(s) ' seconds.'];
		Screen('DrawText',window,msg,xc-150,yc-50,black);
		Screen('Flip', window);
		WaitSecs(1);
	end
	
	%%%%%%%%%%%
	%% Start %%
	%%%%%%%%%%%
	for ii=1:size(trialset,1),
		stim = Screen('MakeTexture', window, imgHash.(... 
				genvarname(trialset{ii})));
		
		Screen('DrawTexture', window, stim);
			% draw texture image to backbuffer. it will be automatically
			% centered in the middle of the display if you don't specify a
			% different destination:

		[VBLTimestamp targetStimOnset]=Screen('Flip', window);
		Screen('Close');
			% Record stimulus onset time in 'targetStimOnset'

		%% Poll for a response, stops on first sucessful
		stopTime = targetStimOnset + maxRespLength;
		FlushEvents;
		while GetSecs < stopTime,
			[keyIsDown, secs, keyCode] = KbCheck;
			if keyIsDown,
	       		break;
	    	end
			WaitSecs(.001);  
				% limits the polling rate
		end
		resp = KbName(keyCode);
			
		%% Feedback delay
		FlushEvents;
		Screen('TextSize', window, 70);
		Screen('DrawText', window, '', xc, yc ,black);
		Screen('Flip', window);
		Screen('Close');
		WaitSecs(.5);
	
		acc  = 0;
		rt   = 0;
		if strfind(acceptableResponses, resp),
			rt = secs - targetStimOnset;
				% if the response is acceptable, 
				% rt takes on a non-zero value
			if strmatch(resp,correct_resps{ii}),
				acc = 1;
			end	
		else
			FlushEvents;
			Screen('TextSize', window, 50);
			Screen('DrawText', window, 'No response detected.', ...
					xc-200, yc-50, black);
			Screen('Flip', window);
			Screen('Close');
		end
		if acc,
			cat_1(cnt_right,:);
			showdisc_cat_r(cat_1(cnt_right,:));
			cnt_right = cnt_right + 1;
			FlushEvents;
		elseif rt > 0.001 && ~acc,
			cat_0(cnt_wrong,:);
			showdisc_cat_r(cat_0(cnt_wrong,:));
			cnt_wrong = cnt_wrong + 1;
			FlushEvents;
		end
		WaitSecs(1);
			% feedback display time
		
		%% Fixation cross/ITI
		FlushEvents;
		Screen('FillRect', window,grey);
		Screen('TextSize', window, 26);
		Screen('DrawText', window, '+', xc, yc ,black);
		Screen('Flip', window);
		Screen('Close');
		trialTimeLeft = maxRespLength - (secs - targetStimOnset);
		WaitSecs(0.5 + trialTimeLeft);
			% Jitter wil go here eventually.

		%% Write out this trial's data..
		fprintf(fid,'%i\t',ii);
		fprintf(fid,'%s\t',trialset{ii})
		fprintf(fid,'%s\t',correct_resps{ii})
		fprintf(fid,'%i\t',acc);
		fprintf(fid,'%f\t',rt);
		fprintf(fid,'%s\t',resp);
		if acc,
			fprintf(fid,'%f\t',cat_1(cnt_right-1,:));
			fprintf(fid,'%s\n','');
		elseif rt > 0.001 && ~acc,
			fprintf(fid,'%f\t',cat_0(cnt_wrong-1,:));
			fprintf(fid,'%s\n','');
		else,
			fprintf(fid,'%f\t',[0 0 0 0 0])
			fprintf(fid,'%s\n','')
		end

	end
	fclose(fid);
	FlushEvents;
    Screen('CloseAll');
    ShowCursor;
    fclose('all');
    Priority(0);
end
