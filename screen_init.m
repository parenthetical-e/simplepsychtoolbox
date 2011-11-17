function [window,screenRect,colors] = screen_init(dbug=0)
% This script does many (hopefully all) the common things needed 
% to initialize any psychtoolbox/Screen session.

	clc;
	close all;
		% clears the workspace
	rand('seed',sum(100*clock));
		% Not sure why manual seeding,
		% but, whatever, leaving it.
	warning('off');
		% Otherwise Screen is very annoying/verbose.
	PsychJavaTrouble; 
		% Needed for Screen to work at all
	
	%% First ensure best speed and timing by 
	%% maximizing the run-level of this script 
	%% (or matlab, not exactly sure).
	priorityLevel=MaxPriority(window);
	Priority(priorityLevel);

	%% Define common colors, in a struct
	colors = {}
	colors.white = WhiteIndex(window);
	colors.black = BlackIndex(window);
	colors.grey = [(white+black)/2 (white+black)/2 (white+black)/2];
	colors.int = colors.white-colors.gray 
	colors.red = [160 25 29];
	colors.green = [59 174 60];

	%% Open the screen window and find its center (xc,yc)
	%% if dbug only open a window covering a portion 
	%% of the top-left corner of the moniter.
	hideCursor;
	if dbug,
		[window,screenRect] = Screen('OpenWindow',0,0,[1,1,400,400]);
	else,
		[window,screenRect] = Screen('OpenWindow',0,0);
	end

	Screen('FillRect', window,colors.grey);
	Screen('Flip', window);
		% Start screen with a grey background
end
