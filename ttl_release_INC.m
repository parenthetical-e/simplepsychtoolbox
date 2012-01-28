function ttl_release_INC(fid,comment),
% Releases (i.e. unpauses) the script on receipt of a TTL pulse. Waits forever.
%
% ttl_release_INC(fid,comment);
%
% IN
%  fid: a fielhandle to a timing log file
%  comment: a label for pulse events (a character array).
%
% OUT:
% When the TTL hits, comment gets written to fid.


% NOTE from the INC wiki:
% 'Use USB 003 HHSC 2×4-C HID NAR 12345 instead of USB 001 HHSC 2×4-C HID 12345. Otherwise KbCheck/KbWait will have trouble getting responses from the scanner button box.'
% While I have no idea what the above means, KbCheck still fails in my testing 
% (using their iMac). Oh well.  GetChar works so we are going with that, 
% hopefully timing precision losses will be minimal.

	stop_time = 1000 + GetSecs;
		% 1000 is close to forever, right....
	disp(num2str(stop_time))
	while stop_time > GetSecs,
		FlushEvents;
		code = GetChar('getExtendedData',0);
			% From help GetChar:
			% 'By setting getExtendedData to 0, all extended timing/modifier 
			% information will not be collected and "when" will be returned 
			% empty.  This speeds up calls to this function.'
			
		if strmatch(code,'5'),
				% 5 is the INC specific TTL code
			log_time(fid,comment);
			return;
		end
	end
end
