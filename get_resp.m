function [acc,rt,resp] = get_resp(corr_resp,acceptable_resps,onset_time,max_time),
% Detect acceptable single key presses, sampling every 0.001 seconds.
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
%  acc: accuracy - {0,1}
%  rt: Reaction time in seconds.
%  resp: The response, a character


	%% Poll for a response, stops on first keyIsDown
	stop_time = onset_time + max_time;
	FlushEvents;
	while GetSecs < stop_time,
		[keyIsDown, secs, keyCode] = KbCheck;
		if keyIsDown,
			break;
		end
		WaitSecs(.001);  
			% limits the polling rate
	end

	resp = KbName(keyCode);
	acc  = 0;
	rt   = 0;
	if strfind(acceptable_resps, resp),
		rt = secs - onset_time;
			% if the response is acceptable, 
			% rt takes on a non-zero value
		if strmatch(resp,corr_resp),
			acc = 1;
		end	
	end
end
