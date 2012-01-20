function load_matrix(inputfilename)
%load the input matrix
global sub matrix 

load_cmd = ['load ' cd '/input/sub' num2str(sub) '_' inputfilename, '.dat'];
eval(load_cmd);
def_cmd = ['matrix = sub' num2str(sub) '_' inputfilename];
eval(def_cmd);