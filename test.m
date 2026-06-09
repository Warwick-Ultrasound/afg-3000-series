clear;
clc;
close all;

% generate a 5 cycle burst at frequency f
f = 4E6;
A = 10; 
N = 1:50;

for ii = 1:length(N)
    tek_afg_set_burst(f, A, N(ii));
end