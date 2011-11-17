function screen_close(fid),
	fclose(fid);
	FlushEvents;
	Screen('CloseAll');
	ShowCursor;
	fclose('all');
	Priority(0);
end
