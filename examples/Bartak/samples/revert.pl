% usage: ?- revert([1,2,3],R).
% R = [3, 2, 1].
 
revert(List,RevList):-
	rev(List,[],RevList).
 
rev([H|T],S,R):-
	rev(T,[H|S],R).
	rev([],R,R).
 