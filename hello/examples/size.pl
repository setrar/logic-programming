% (a) length of a list

size([],0).
size([H|T],N) :- size(T,N1), N is N1+1.
%  or size([_|T],N) :- size(T,N1), N is N1+1.

% ?- size([1,2,3,4],N).
% 	N = 4.