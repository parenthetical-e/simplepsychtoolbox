function end_exp
% display last message, lock screen, close all

global window xc yc black fid
%% last screen
% locks screen so that P won't have access to code/data etc.
% NOTE: exit with 'e'

respo='f';
corre='e';
screen('TextSize', window, 30);
    screen('DrawText', window, '              Thank you for your time.                   ', xc-340,  yc-75, black);
    screen('DrawText', window, 'Please tell the experimenter that you are finished.', xc-340,  yc, black);
    Screen('Flip', window); 
    FlushEvents
while respo~= corre
    respo=GetChar;
end
%% close things up
fclose(fid); % Close data file. 
ListenChar(0);
ShowCursor;
screen('CloseAll');