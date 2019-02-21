likes(alice, music).
likes(bob, hiking).

likes(P,Q) :-
   ( P = alice, Q = music ) ; ( P = bob , Q = hiking).
