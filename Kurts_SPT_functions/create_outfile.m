function create_outfile(outfilename)
%create a file that you will write data into later
%note: extension can be .dat or .txt (.dat cannot be opened via excel)

global fid sub 

outfile = [cd '/data/sub' num2str(sub), '_' outfilename, '.txt']; % category responses
fid = fopen([outfile],'w');