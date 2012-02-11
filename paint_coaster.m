function [VBLTimestamp onset_time] = paint_coaster(n_sec,stim_params,window,coords,colors),
% Paints a parametric black and white sinusoidal grating on the Screen.
% 
% [VBLTimestamp onset_time] = paint_coaster(n_sec,stim_params,window,coords,colors);
%
% IN
%  n_sec: how long in seconds it is onscreen.
%  stim_params: parameters for the grating, formated as in ii_stim.dat,
%    for example, 
%    1	21.4584	47.84	-1
%    the first column is 1 or 2 the category label,
%    the next two cols are the acutal parameters,
%    the final col is unkknwon but was left to be 
%    comptably with the coaster parameter file provided 
%    by B Speiring.
%
%  window,coords,colors: standard Screen() variables.
% 
% OUT
%  VBLTimestamp: ?
%  onset_time: the time in seconds when the coasters was intially painted.

	x = coords.meshX;
	y = coords.meshY;

	% This code, and the parameter files needed for drawing of sinusoidal
	% gratings (i.e. coasters) was kindly provided by Brian Speiring.

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
	disc = coords.circlespace.*wave;
	Screen('FillRect',window,colors.grey);
	screen('PutImage',window,colors.grey+colors.inc*disc);
	[VBLTimestamp onset_time] = Screen('Flip', window);
	Screen('Close');
	WaitSecs(n_sec);
end
