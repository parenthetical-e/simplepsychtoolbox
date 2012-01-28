function log_time(fid,comment),
% Logs the the current time (in seconds) and a comment.
% 
% IN
% 	fid: a file handle
% 	comment: a character array that will be written with the time.

	fprintf(fid,'%s\t',num2str(GetSecs));
	fprintf(fid,'%s\n',comment);
end
