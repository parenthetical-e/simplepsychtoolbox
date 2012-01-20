function prep_sound
%intialize psychsound and preload sound files

global pahandle1

% initiialize
InitializePsychSound(1);
freq = 48000; 
nrchannels = 1;
pahandle1 = PsychPortAudio('Open', [], [], 3, freq, nrchannels);

%load sounds
imagepath = '/images';
spatternname = '*.wav';
soundlist = dir(fullfile(imagepath,spatternname));
imdata = cell(1,numel(soundlist));
for k=1:numel(soundlist)
    imdata{k} = wavread(fullfile(imagepath,soundlist(k).name));
end