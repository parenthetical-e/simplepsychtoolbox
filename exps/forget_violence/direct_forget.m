function direct_forget(sub_num,word_file,N),
% Display word from file followed by a memory instruction: 'Remeber' or 'Forget'.
% 
% This script reproduces the training portion of Nowika et al (2011), 
% Forgetting of Emotional Information Is Hard: An fMRI Study of Directed 
% Forgetting, Cereb. Cortex (2011) 21 (3): 539-549.
% 
% Except words are used in place of images.  It was created to see what effect 
% violence (seperate from valence and arosal) has on directed forgetting.
% 
% IN
%  sub_num: the subject number
%  word_file: a text file formated like words.txt
%  N the number of trials to run.

	%% USER DEFINITIONS %%
	dbug = 0;
	%% =========== 
	
	if mod(N,2) > 0,
		error('N must be even.');
	end
	
	% 0. Make a Screen
	[window,screenRect,colors] = screen_init(dbug);
	coords = define_coords(window,screenRect);
	
	% 1a. Read in WORDS and the rest of their data 
	% (which are kept for consistency on write).
	[words valM valSD aroM aroSD violence] = textread(...
			word_file,'%s %s %s %s %s %s');
	
	% 1b. Then randomize the order of words, and the rest 
	% (agian for consistency).
	random_index = randperm(length(words));
	words = words(random_index);
	valM = valM(random_index);
	valSD = valSD(random_index);
	aroM = aroM(random_index);
	aroSD = aroSD(random_index);
	violence = violence(random_index);
	
	words_mat = char(words);
			%% Change words into a char array so all words occupy
			%% the same amount of line space making centering the text easy

	% 2. Create a logging file for the words that are shown	
	word_log = [num2str(sub_num) '_instruction_' word_file];
	if exist(word_log, 'file'),
		disp(['Deleting ' word_log]);
		delete(word_log);
	end
	fid = fopen(word_log,'a+');

	% 3. Countdown to the start
	write_countdown(5,window,coords,colors);
		% Display a counter informing Ss the experiment will
		% start in 5 seconds
	
	% 4. Create a binary array that represents the memory instructions
	% which has an even number of 0s and 1s in a random order. Length is N.
	% 1 = Remember
	% 0 = Forget
	counter = 0;
	instruct_array = shuffle([ones(1,N/2) zeros(1,N/2)]);
	
	% START THE EXPERIMENT
	for ii=1:N,
		
		% Blank screen for 1 sec
		paint_nothing(2,window,coords,colors);
		
		% Put the word at position ii onscreen followed by a fixation
		write_msg(0.5,words_mat(ii,:),36,-45,-10,window,coords,colors);
		paint_fixation(1.5,window,coords,colors);
		
		% Get the memory instruction and write it onscreen
		[instruct counter] = get_instruct(instruct_array,ii,counter);
		write_msg(1.5,instruct,36,-60,-10,window,coords,colors);
		
		% Log the trial count, the word, and the instruction
		fprintf(fid,'%s\t',num2str(ii));
		fprintf(fid,'%s\t',words{ii});
		fprintf(fid,'%s\t',valM{ii});
		fprintf(fid,'%s\t',valSD{ii});
		fprintf(fid,'%s\t',aroM{ii});
		fprintf(fid,'%s\t',aroSD{ii});
		fprintf(fid,'%s\t',violence{ii});
		fprintf(fid,'%s\n',instruct);
	end
	
	% Finally dump the unused words at the end, using 
	% the instruct code of 'None'.
	for ii=(N+1):size(words_mat,1),
		fprintf(fid,'%s\t',num2str(ii));
		fprintf(fid,'%s\t',words{ii});
		fprintf(fid,'%s\t',valM{ii});
		fprintf(fid,'%s\t',valSD{ii});
		fprintf(fid,'%s\t',aroM{ii});
		fprintf(fid,'%s\t',aroSD{ii});
		fprintf(fid,'%s\t',violence{ii});
		fprintf(fid,'%s\n','None');
	end
	
	thank_and_lock(window,coords,colors);
	fclose(fid);
	screen_close();
end
