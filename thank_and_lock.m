function thank_and_lock(window,coords,colors),
% Leave a 'thank you' onscreen until the secret key ('f') is pressed.
% 
% thank_and_lock(window,coords,colors);
% 
% IN
%  window,coords,colors: standard Screen() variables.

	m1 = 'Thank you for your time.';
	m2 = 'Please tell the experimenter that you are finished.';
	write_msg(5,m1,16,-75,0,window,coords,colors);
	write_msg(0,m2,16,-180,0,window,coords,colors);
		% Give them five seconds to read the first line.
		% The zero in the second leaves m2 up for infinity,
		% as nothing comes after but this infinite loop.

	while 1,
		if strcmp(GetChar, 'f'),
			return;
				% Kills thank_and_lock() 
				% and returns to the caller
		end
	end
end