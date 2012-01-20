% Your 'end_exp()' is replaced by
thanks_and_lock(window,coords,colors);
% followed by my
screen_close();

% Start_exp() does the same thing as my 
screen_init();
% excepting the sub number request and hold till return portions
% which are I think bet accomplished directly, i.e. just use:
sub_number = input('Subject Number (test=999): ');
i=input('press return');

% prep_sound() was reformatted, functionalized and renamed for consistency
[pid, sounds_data] = preload_sounds(sound_dir_name);

% create_outfile() and load_matrix() were functionalized and 
% reformated a little
[fid] = create_outfile(sub_number,base_file_name);
load_matrix_from_input_dir(sub_number,input_file_name);

% feedback.m I leave to you.... Look at Contents.m and use help function_name
% inside matlab to see what simplepsychtoolbox can do.