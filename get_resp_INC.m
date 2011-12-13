function [acc,rt,resp] = get_resp_INC(corr_resp,acceptable_resps,onset_time,max_time),
	%% A special response collection function for 
	%% the Intermountain Neuroimaging Consortium (INC) facility
	%% at U.C. Boulder

	%% Wait for a response from the keyboard,
	%% sampling ever 0.001 seconds, once detected 
	%% is compared to against acceptable_resps
	%% and corr_resp

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
	stop_time = onset_time + max_time;
	while GetSecs < stop_time,
		FlushEvents;
		start_time = GetSecs;
		resp = GetChar;
		elapsed_time = GetSecs - start_time;
		if strfind(acceptable_resps, resp),
			rt = elapsed_time;
				% if the response is acceptable, 
				% rt takes on a non-zero value
			if strmatch(resp,corr_resp),
				acc = 1;
			end
			break;
		end
		WaitSecs(.001); 
			% limits the polling rate
	end
end

