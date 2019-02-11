% Usage:	
% ?- member(X,[1,2,3]).
% X = 1 .

member(X,[X|T]).
member(X,[_|T]):-
	member(X,T).

