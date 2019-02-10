# (b) summing elements of a list of numbers

sumlist([],0).
sumlist([H|T],N) :- sumlist(T,N1), N is N1+H.

% ?- sumlist([4,7,8,3,6],N).
% N = 28.