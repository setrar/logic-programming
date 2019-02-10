% (c) list membership 

member(X,[X|_]).
member(X,[_|T]) :- member(X,T).

% ?- member(3,[1,2,3,4,5]).
%true
% ?- member(0,[1,2,3,4,5]).
%false