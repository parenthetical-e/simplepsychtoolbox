function [acc,rt,resp] = get_resp_INC(corr_resp,acceptable_resps,onset_time,max_time),
% Detect acceptable single key presses from the INC response box, sampling every 0.001 seconds.
%
%  [acc,rt,resp] = get_resp_INC(corr_resp,acceptable_resps,onset_time,max_time);
%
% IN
%  corr_resp: the right answer, a character (e.g '1').
%  acceptable_resps: a character array of valid responses (e.g. ['1' '2']]).
%  onset_time: typically responses are timed from a stimulus onset,
% 		this is the time that stimulus happend.  Or use GetSecs;.
%  max_time: how long in seconds should the function wait for a response, 
%		a float.
% OUT
%  acc: Accuracy - {0,1}
%  rt: Reaction time in seconds.
%  resp: The response
% 
% This is a special response collection function for the Intermountain 
% Neuroimaging Consortium (INC) facility at U.C. Boulder.  It works
% around limitations of that system.


	rt = 0;  
		% an rt of exactly 0 is meaningful/special
		% in simplepsychtoolbox.  It should become 
		% not-zero only when a acceptable_resp has been 
		% seen.  '0' means implies 'no response detected'
	acc = 0;

	%% Poll for a response, stops when get GetChar takes on
	%% a acceptable_resps value.  Unlike get_resp, which
	%% ends on eny keypress this function ends only with
	%% an acceptable_response.  This is not ideal
	%% but I can't find a way to test for resp changing from its
	%% (non-empty but char) default value to something else.
	start_time = GetSecs;
	stop_time = onset_time + max_time;
	while GetSecs < stop_time,
		if CharAvail,
			resp = GetChar('getExtendedData',0);
				% From help GetChar:
				% 'By setting getExtendedData to 0, all extended 
				% timing/modifier information will not be collected and
				%  "when" will be returned empty.  This speeds up calls
				%  to this function.'
				
			if strfind(acceptable_resps, resp),
				rt = GetSecs - onset_time;
					% if the response is acceptable, 
					% rt takes on a non-zero value
				if strmatch(resp,corr_resp),
					acc = 1;
				end
				break;
			end
		end
		WaitSecs(.001); 
			% limits the polling rate
	end
end