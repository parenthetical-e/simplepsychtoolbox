N = 117
N = num2str(N)

TR = 1.5

% PAVLOV
pba = [N '_126_pavlov_A.dat']
% pavlov_A(pba,TR)

pbb = [N '_54_pavlov_B.dat']
% pavlov_B(pbb,TR)

% RUN
r1 = [N '_180_run_trials_reward_cat_1.dat']
r0 = [N '_180_run_trials_reward_cat_0.dat']

rfa = [N '_run_trials_A.dat']
% run_A(rfa,r0,r1,TR)

rfb = [N '_run_trials_B.dat']
% run_B(rfb,r0,r1,TR)
% LOCALIZER
lc = [N '_54_localizer.dat']
% localizer(lc,TR)
