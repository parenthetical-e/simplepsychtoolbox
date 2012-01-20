function function_tester(),
% Do just the bare number of things needed to get Screen up and running.
%
% When learning to use these Screen() interface functions it may be useful to
% play with a single function in isolation.	Unfortunantly nearly all assume
% and require that a Screen window pointer, coords and colors are defined.
% This fullfills that requirement, and nothing else. As such any other
% variable and globals need to be created and defined by your hand.

	%% USER DEFINITIONS %%
	dbug = 1; 
	%% --------------- %%

	[window,screenRect,colors] = screen_init(dbug);
	[coords] = define_coords(window,screenRect);

	% TEST FUNCTION GOES HERE.
	
	% For example,
	% first define the variables,
	msg = 'This is a fun and comfortable place to test.';
	n_sec = 2;
	fontsize = 16;
	xoff = -200;
	yoff = 0;
	
	% Using try so when something goes wrong in your testinf
	% Screen etc can be cleaned up
	try,
		write_msg(n_sec,msg,fontsize,xoff,yoff,window,coords,colors);
			% Writes 'This is a fun and comfortable place to test.' 
			% onto the screen for 10 seconds (n_sec) in size 16 font
			% with the text moved left 200 pixels so it sits in the center 
			% of the screen.
			% 
			% To undersand how this funtion works try changing the variables 
			% above preferably one at a time (e.g. what happens if you set 
			% xoff to 0 instead.).
			% 
			% For berevity's sake this would have done the same thing 
			% (exception is that the 'Brevity!' is printed instead):
			% write_msg(10,'Brevity!',16,-200,0,window,coords,colors);
	catch err,
		disp('Dying gracefully...');
		screen_close();
		rethrow(err);
	end

	%% ------------------- %%
	
	% Or for ttl testing instead use:
	% try,
	% 	% then call the function.
	% 	fid = fopen('test','a+');
	% 	write_msg(0,'Hit 5',fontsize,xoff,yoff,window,coords,colors);
	% 	ttl_release_INC(fid,'HIT',0);
	% 	write_msg(n_sec,msg,fontsize,xoff,yoff,window,coords,colors);
	% catch,
	% 	disp('Dying gracefully...');
	% 	fclose(fid);
	% 	screen_close();
	% end
	
	screen_close();
end