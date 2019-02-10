male(james1).
male(charles1).
male(charles2).
male(james2).
male(george1).

female(catherine).
female(elizabeth).
female(sophia).

parent(charles1, james1).
parent(elizabeth, james1).
parent(charles2, charles1).
parent(catherine, charles1).
parent(james2, charles1).
parent(sophia, elizabeth).
parent(george1, sophia).
  
% ?- parent(charles1, george1). 
% false.

% ?- parent(charles1,X). 
% X = james1.

% ?- parent(X,charles1). 
% X = charles2 .