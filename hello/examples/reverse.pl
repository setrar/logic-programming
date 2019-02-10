% (d) reversing a list

reverse(List, Reversed) :-
          go(List, [], Reversed).

go([], Reversed, Reversed).
go([Head|Tail], SoFar, Reversed) :-
          go(Tail, [Head|SoFar], Reversed).
          
% ?- reverse([1,2,3,4,5], R).
% R = [5, 4, 3, 2, 1].