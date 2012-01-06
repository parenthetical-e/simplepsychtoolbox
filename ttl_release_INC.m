function ttl_release_INC(max_time,fid,comment,strict),
% Releases (i.e. unpauses) the script on receipt of a TTL pulse.  
%
% ttl_release_INC(max_time,fid,comment,strict);
%
% IN
%  max_time: how long in seconds should we wait for a TTL pulse
%  fid: a fielhandle to a timing log file
%  comment: a label for pulse events (a character array).
%  strict: when 1 and max_time is exceed an error is generated; use with care.

	stop_time = max_time + GetSecs;
	while stop_time < GetSecs,
		code = GetChar;
		if strmatch(code,'5'),
				% 5 is the INC specific TTL code
			log_time(fid,comment,'async');
			return;
		end
	end
	if strict,
		error(['ttl was not detected within ' num2str(max_time) '.']);
			% return (above) should exit, if the loop is exited cleanly 
			% that is (counterintuitivly) an error and everything 
			% needs to die.
	else,
		disp(['ttl was not detected within ' num2str(max_time) '.']);
			% issue a warning, no error.
	end
end
