% https://stackoverflow.com/questions/8297574/difference-between-logic-programming-and-functional-programming

abs(X, R):-
   X>0,
   R is X.
abs(X, R):-
   R is -X.
   
% backtracking example
% Another difference between logic and functional is backtracking. 
% In functional programming once you enter the body of the function 
% you cannot fail and move to the next definition. 

% For example you can write
% > abs(x) -> 
%     if x>0 x else -x
% or even use guards:
% > abs(x) x>0 -> x;
% > abs(x) x=<0 -> -x.
%
% but you cannot write
% > abs(x) ->
%      x>0,
%      x;
% > abs(x) ->
%      -x.
% on the other hand, in Prolog you could write

% ?- abs(X, R):-
%        X>0,
%        R is X.
% ?- abs(X, R):-
%        R is -X.

% call
% ?- abs(-3, R).