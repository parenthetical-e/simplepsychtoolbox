function [fid,file_name] = create_log(base_file_name),
% Creates a log file for timing or data, deleting old verions with a warning.

	file_name = ['log_' base_file_name];
	if exist(file_name, 'file'),
		disp(['Deleting ' file_name]);
		delete(file_name);
	end
	fid = fopen(file_name,'a+');
		% create ttl logging file	
end