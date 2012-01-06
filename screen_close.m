function screen_close(),
% Ends a running experiment cleanly.
%
% Undoes the work of screen_init(), flushes and closes the Screen session and 
% returns run priority and mouse to normal.

	FlushEvents;
	Screen('CloseAll');
	ShowCursor;
	fclose('all');
	Priority(0);
end
