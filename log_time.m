function log_time(fid,comment,mode),
% Logs the the current time (in seconds) and a comment.
% 
% IN
% 	fid: a file handle
% 	comment: a character array that will be written with the time.
% 	mode: determines whether the write is 'async' or 'sync', see fprintf().

	fprintf(fid,'%f\t',GetSecs,mode);
	fprintf(fid,'%s\n',comment,mode);
end
