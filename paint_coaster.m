function paint_coaster(stim_params,window,coords,colors),
	% We use the fact that sin(x) has 1 cycle every 2*pi pixels.  That
	% means that sin(k*x) has k cycles every 2*pi pixels.  
	% Using a conversion factor of stim_pixels/visual_angle_in_degrees 
	% and after doing some algebra we see that the following value of k 
	% will give produce the correct number of cycles per degree.
	cycles_per_degree = stim_params(2);
	k = (2*pi*coords.visual_angle_in_degrees*cycles_per_degree)/...
		coords.stim_pixels;

	% Next we use that the gradient of the curve 
	% z = sin(theta)*x+cos(theta)*y
	% has constant length, meaning that the spatial frequency of 
	% sin(k*x) will be the same as the spatial frequency of
	% sin(k*(sin(theta)*x+cos(theta)*y)) for all values of theta.
	orientation_angle = stim_params(3);
	g = sind(orientation_angle);
	h = cosd(orientation_angle);
	wave=sind((g*x+h*y)*k);

	% Draw the disc
	disc = (coords.circlespace).*wave;
	Screen('FillRect',window,colors.gray);
	screen('PutImage',window,(colors.gray+colors.inc)*disc);
	Screen('Flip', window);
	Screen('Close');
end
