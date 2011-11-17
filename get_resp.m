function [acc,rt,resp] = get_resp(corr_resp,acceptable_resps,onset_time,max_time),
	%% Wait for a response from the keyboard,
	%% sampling ever 0.001 seconds, once detected 
	%% is compared to against acceptable_resps
	%% and corr_resp

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
