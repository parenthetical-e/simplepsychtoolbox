function feedback(input, time)
% presents feedback
% correct & incorrect= visual and auditory
% too slow= visual only

% note: need to call "prep_sound" prior to calling this function

global window xc yc pahandle1

if input ==1
    %Correct_feedback
    screen('TextSize', window, 100);
    screen('DrawText', window, 'Correct', xc-150,  yc-20, [0 75 0]);
    filename1= 'stimuli/correct.wav';
    wavedata1 = transpose(wavread(filename1));
    PsychPortAudio('FillBuffer', pahandle1, wavedata1,0);
    Screen('Flip', window);
    PsychPortAudio('Start', pahandle1);
    FlushEvents
    waitsecs(time);
    PsychPortAudio('Stop', pahandle1);
    data=[];
elseif input==2
    %incorrect_feedback
    screen('TextSize', window, 100);
    screen('DrawText', window, 'Wrong', xc-150,  yc-20, [75 0 0]);
    filename1= 'stimuli/incorrect.wav';
    wavedata1 = transpose(wavread(filename1));
    PsychPortAudio('FillBuffer', pahandle1, wavedata1,0);
    Screen('Flip', window);
    PsychPortAudio('Start', pahandle1);
    FlushEvents
    waitsecs(time);
    PsychPortAudio('Stop', pahandle1);
    data=[];
elseif input==3
    %too slow feedback
    screen('TextSize', window, 90);
    screen('DrawText', window, 'Too Slow', xc-185,  yc-20, [75 0 0]);
    Screen('Flip', window);
    FlushEvents
    waitsecs(time);
end