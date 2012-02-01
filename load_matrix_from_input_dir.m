function load_matrix_from_input_dir(sub_number,input_file_name),
% Document this please Kurt. WTF is this!?!

	load_cmd = ['load ' cd '/input/sub' num2str(sub_number) '_' ...
			input_file_name, '.dat'];
	eval(load_cmd);

	def_cmd = ['matrix = sub' num2str(sub) '_' input_file_name];
	eval(def_cmd);

end