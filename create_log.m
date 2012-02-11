function [fid,file_name] = create_log(base_file_name),
% Creates a log file for timing or data, deleting old verions with a warning.

	old_wd = pwd;
		
	% Create the log directory if needed
	if ~exist('log','dir'),
		mkdir('log');
	end
	cd(fullfile(pwd,'log'));
	
	% Create the log file name, deleting old verions
	% with a warning
	file_name = [base_file_name '.log'];
	if exist(file_name, 'file'),
		disp(['Deleting ' file_name]);
		delete(file_name);
	end
	
	% create the file handle
	fid = fopen(file_name,'a+');
	
	cd(old_wd);
end