function [images_data] = preload_images(img_dir_name),
% Prereads all the files in img_dir_name into a struct named images_data.
	
	file_names = dir([img_dir_name]);
		% Get all the files
	images_data = {};
		% init
	for ii=1:size(file_names,1),
		%% Try to open, img, this iterations file name.
		%% Let imread() try and workout the format.
		%% If it fails inform and move on to the next 
		%% iteration.  If it works store the data in 
		%% images_data{} using genvarname() to create
		%% a matlab compatible field name. genvarname() 
		%% is needed to retrieve data as well, of course.
		img = file_names(ii).name;
		try,
			img_data=imread([img_dir_name, '/', img]);
			images_data.(genvarname(img)) = img_data;
		catch,
			disp(['Could not open ' img]);
			continue;
		end
	end
end
