function [coords] = define_coords(window,screenRect)
% Defines a coordinate system for paint_coasters(); window and screenRect come from screen_init().
%
% [coords] = define_coords(window,screenRect)

	coords = {}; % a struct is made
	
	coords.visual_angle_in_degrees = 6; 
	coords.dist_to_screen_cm = 76;

	coords.xc = screenRect(3)/2; 
	coords.yc = screenRect(4)/2;

	% Obtain screen size and pixel info 
	[screen_size_mm(1), screen_size_mm(2)] = Screen('DisplaySize', 0);
	coords.screen_width_cm = screen_size_mm(1)/10;
	coords.screen_height_cm = screen_size_mm(2)/10;
	[coords.screen_width_pixels,coords.screen_height_pixels] = ...
			Screen('WindowSize', 0);
	coords.screen_pixel_density = coords.screen_width_pixels/...
			coords.screen_width_cm;
	coords.stim_width = (2*coords.dist_to_screen_cm*...
			tan((coords.visual_angle_in_degrees/2)*(pi/180)));
	coords.stim_pixels = coords.stim_width*coords.screen_pixel_density;
	coords.stim_radius = ceil(coords.stim_pixels/2);
		
	% create an appropriate circlespace matrix
	h = 2*coords.stim_radius+1;
	center_point = coords.stim_radius+1;
	coords.center_point = center_point;
		% store it too
	circlespace = zeros(h,h);
	for i = 1:h
	   for j = 1:h
			if (((i-center_point)^2 + (j-center_point)^2) ...
				<= coords.stim_radius^2)
					circlespace(i,j) = 1;
			end
	   end
	end
	[coords.meshX,coords.meshY] = meshgrid(1:h,1:h);
	coords.circlespace = circlespace;
end
