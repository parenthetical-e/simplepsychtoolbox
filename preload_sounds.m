function [pid sounds_data] = preload_sounds(sound_dir_name),
% Prereads all the sound files sound_dir_name into a struct named sounds_data.
% 
% [pid, sounds_data] = preload_sounds(sound_dir_name);
%
% IN
%   sound_dir_name: the name of the directory
% OUT
%  pid: the handle to the audioport
%  sounds_data: the data

	%% Init
	InitializePsychSound(1);
	freq = 48000; 
	nrchannels = 1;
	pahandle1 = PsychPortAudio('Open', [], [], 3, freq, nrchannels);
	
	%% Preread the sounds
	%% Get just the wave files and read them in.
	file_list = dir(fullfile(sound_dir_name,'*.wav'));
	sounds_data = cell(1,numel(file_list));	% Init
	for k=1:numel(file_list)
	    sounds_data{k} = wavread(fullfile(sound_dir_name,file_list(k).name));
	end
	
end