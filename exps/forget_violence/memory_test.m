function memory_test(sub_num,instruct_word_file),
% Display word from file followed by querying if that word was old or new.
% 
% This script reproduces the testinf portion of Nowika et al (2011), 
% Forgetting of Emotional Information Is Hard: An fMRI Study of Directed 
% Forgetting, Cereb. Cortex (2011) 21 (3): 539-549.
% 
% Except words are used in place of images.  It was created to see what effect 
% violence (seperate from valence and arosal) has on directed forgetting.
% 
% IN
%  sub_num: the subject number
%  word_file: a text file formated like words.txt

	%% USER DEFINITIONS %%
	dbug = 0;
	%% =========== 

	% 0. Make a Screen
	[window,screenRect,colors] = screen_init(dbug);
	coords = define_coords(window,screenRect)

	% 1a. Read in WORDS and the rest of their data 
	% (which are kept for consistency on write).
	[l_index words valM valSD aroM aroSD violence instruction] = textread(...
			instruct_word_file,'%s %s %s %s %s %s %s %s');

	% 1b. Then randomize the order of words, and the rest 
	% (agian for consistency).
	random_index = randperm(length(words));
	l_index = l_index(random_index);
	words = words(random_index);
	valM = valM(random_index);
	valSD = valSD(random_index);
	aroM = aroM(random_index);
	aroSD = aroSD(random_index);
	violence = violence(random_index);
	instruction = instruction(random_index);

	words_mat = char(words);
			%% Change words into a char array so all words occupy
			%% the same amount of line space making centering the text easy

	% 2. Create a logging file for the words that are shown	
	word_log = [num2str(sub_num) '_memory_' instruct_word_file];
	if exist(word_log, 'file'),
		disp(['Deleting ' word_log]);
		delete(word_log);
	end
	fid = fopen(word_log,'a+');

	% 3. Countdown to the start
	write_countdown(1,window,coords,colors);
		% Display a counter informing Ss the experiment will
		% start in 5 seconds

	% START THE EXPERIMENT
	for ii=1:size(words_mat,1),

		% Blank screen for 1 sec
		paint_nothing(2,window,coords,colors);

		% Put the word at position ii onscreen followed by a fixation
		write_msg(0.5,words_mat(ii,:),36,-45,-10,window,coords,colors);
		paint_fixation(1.5,window,coords,colors);

		% Is old or new or new the right answer?
		if strcmp(instruction{ii},'None')
			corr_resp = 'p';
		else
			corr_resp = 'q';
		end
		
		% Ask about memory.
		write_msg(0.0,'Old or New?',36,-60,-10,window,coords,colors);
		[acc rt resp] = get_resp(corr_resp,['p' 'q'],GetSecs,3);
		
		% Log all the data.
		fprintf(fid,'%s\t',num2str(ii));
		fprintf(fid,'%s\t',l_index{ii});
		fprintf(fid,'%s\t',words{ii});
		fprintf(fid,'%s\t',valM{ii});
		fprintf(fid,'%s\t',valSD{ii});
		fprintf(fid,'%s\t',aroM{ii});
		fprintf(fid,'%s\t',aroSD{ii});
		fprintf(fid,'%s\t',violence{ii});
		fprintf(fid,'%s\t',instruction{ii});
		fprintf(fid,'%s\t',num2str(acc));
		fprintf(fid,'%s\t',num2str(rt));
		fprintf(fid,'%s\n',resp);
	end

	thank_and_lock(window,coords,colors)
	fclose(fid);
	screen_close()
end
