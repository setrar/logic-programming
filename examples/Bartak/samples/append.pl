% Usage
% 10 ?- append([1,2,3],[4,5],X).
% X = [1|_1440].

% 11 ?- append(A,B,[1,2,3,4,5]).
% A = [],
% B = [1, 2, 3, 4, 5] .

append([],R,R).
append([H|T],L2,[H|R]):-
	append(T,L2,R2).

