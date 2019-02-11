% usage: ?- perm([1,2,3],P).
 
perm([H|T],Perm):-
perm(T,SP),insert(H,SP,Perm).
perm([],[]).
 
insert(X,T,[X|T]).
insert(X,[H|T],[H|NT]):-
insert(X,T,NT).