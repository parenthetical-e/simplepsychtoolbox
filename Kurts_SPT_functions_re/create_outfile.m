function [fid] = create_outfile(sub_number,base_file_name),
% Creates a file (returning its handle) for later writing.
%
% [fid] = create_outfile(sub_number,out_file_name)
% 
% IN
%  sub_number: the subject number
%  base_file_name: the base name of the file to be created
% OUT
%  fid: a file handle
% 
% Note: extension can be .dat or .txt (.dat cannot be opened in excel).

	out_file_name = [cd '/data/sub' num2str(sub_number), ...
			'_' base_file_name, '.txt'];
		% category responses
	fid = fopen([out_file_name],'w');
	
end