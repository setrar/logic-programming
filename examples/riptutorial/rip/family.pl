father_child(fred, susan).
mother_child(hillary, joe).
child_of(X,Y):-
   father_child(Y,X)
   ;
   mother_child(Y,X).
