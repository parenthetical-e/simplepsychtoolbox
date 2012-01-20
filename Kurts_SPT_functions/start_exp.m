function start_exp
% generic program start function

clear mex
clear mex

%% General Setup 
clc 
clear all
close all
rand('seed',sum(100*clock))
warning('off')
PsychJavaTrouble 
% Screen('Preference', 'SkipSyncTests',1);

%% Setup for experiment
global sub run

%% Get Subject Number
clc
sub = input('Subject Number (test=999): ');
% run = input('Run (1-3): ') 
i=input('press return');
