/*************************/
/*  Word Puzzle Solver   */
/*     (c) R. Bart‡k     */
/*         1996          */
/*************************/

% usage: ?-solve_puzzle(Puzzle).
%   where Puzzle is a mask of word puzzle (input)
% example: ?-solve_puzzle(["01111","01011","11110","10010","11111","11110","11010"]).

% database of possible words is encoded in facts w(Length,Words)
% where Words is a list of words (word=list of letters) containing Length letters
%    example w(10,["etroitesse","europeenne","vilipender"]).
% for more info see enclosed complex example (WPexample.pr)

:-op(700,xfx,::).

solve_puzzle(Puzzle):-
	gen(Puzzle,Vars,Cons,PP),
	sort_dom(Vars,NewVars),
	test(Cons),
	gen_mem(NewVars),
	pp(PP).

% P1 letter of X1 is the same as P2 letter of X2
sl(X1,P1,X2,P2):-
	mem(Comm,X1,P1),
	mem(Comm,X2,P2).

mem(X,[H|T],P):-
	P>1,P1 is P-1,
	mem(X,T,P1).
mem(X,[X|_],1).

sort_dom([X|Vs],NewVars):-
	sort_dom(Vs,AuxVs),
	new_var(X,NX),
	ins_dom(NX,AuxVs,NewVars).
sort_dom([],[]).

new_var(X::D,X::(S-D)):-
	dom_size(D,S),
	D=[E|_],
	gen_var(X,E).

gen_var([H|T],[_|R]):-
	gen_var(T,R).
gen_var([],[]).

dom_size([_|T],S):-
	dom_size(T,S1),
	S is S1+1.
dom_size([],0).

ins_dom(X,[Y|T],[X,Y|T]):-
	X=(_::(SX-_)),Y=(_::(SY-_)),
	SX=<SY,!.
ins_dom(X,[Y|T],[Y|NT]):-
	ins_dom(X,T,NT).
ins_dom(X,[],[X]).

test([C|Cs]):-
	C,test(Cs).
test([]).

gen_mem([X::(_-D)|T]):-
	domain_mem(X,D),
	gen_mem(T).
gen_mem([]).

domain_mem(X,[X|T]).
domain_mem(X,[_|T]):-
	domain_mem(X,T).


% gen(Cross,Vars,Constr,Puzzle)
% generate Vars and Constraints for puzzle Cross
%   prepare Puzzle for pretty print

gen(Cross,Vars,Constr,Puzzle):-
	Cross=[Line|Lines],
	gen_empty(Line,EmptyCol),  % generate given number of empty columns
	gen_empty(Cross,EmptyRow), % generate given number of empty rows
	gen_dir(Cross,[],[],EmptyCol,AuxVs,AuxCs,Col),        %gen. vars+cons accord. rows
	gen_dir(Col,AuxVs,AuxCs,EmptyRow,Vars,Constr,Puzzle). %gen. vars+cons accord. columns

gen_empty([_|T],[[]|GT]):-
	gen_empty(T,GT).
gen_empty([],[]).


% gen_dir(Cross,OldVs,OldCs,OldLs,NewVs,NewCs,NewLs)
% generate vars+constraints according to line and prepare orthogonal lines

gen_dir([L|Ls],OldVs,OldCs,OldLs,NewVs,NewCs,NewLs):-
	gen_dir(Ls,OldVs,OldCs,OldLs,AuxVs,AuxCs,AuxLs),
	gen_line(L,AuxVs,AuxCs,AuxLs,NewVs,NewCs,NewLs).
gen_dir([],Vs,Cs,Ls,Vs,Cs,Ls).

gen_line([H|T],OldVs,OldCs,[A|R],NewVs,NewCs,[[H|A]|NewLs]):-
	[H]="0",!,
	gen_line(T,OldVs,OldCs,R,NewVs,NewCs,NewLs).
gen_line([H|T],OldVs,OldCs,[A|R],NewVs,NewCs,NewLs):-
	[H]="1",!,
	gen_cont_line(T,V,1,OldVs,OldCs,R,AuxVs,NewCs,AuxLs,Size),
	(w(Size,Dom) -> (NewVs=[V::Dom|AuxVs],NewLs=[[(V,1)|A]|AuxLs])
																;(NewVs=AuxVs,NewLs=[[H|A]|AuxLs])).
gen_line([(V1,C1)|T],OldVs,OldCs,[A|R],NewVs,NewCs,[[(V1,C1)|A]|AuxLs]):-
	!,gen_cont_line(T,V2,1,OldVs,OldCs,R,AuxVs,AuxCs,AuxLs,Size),
	(w(Size,Dom) -> (NewVs=[V2::Dom|AuxVs],NewCs=[sl(V1,C1,V2,1)|AuxCs])
																;(NewVs=AuxVs,NewCs=AuxCs)).
gen_line([],Vs,Cs,[],Vs,Cs,[]).

gen_cont_line([H|T],_,Size,OldVs,OldCs,[A|R],NewVs,NewCs,[[H|A]|NewLs],Size):-
	[H]="0",!,
	gen_line(T,OldVs,OldCs,R,NewVs,NewCs,NewLs).
gen_cont_line([H|T],V,Size,OldVs,OldCs,[A|R],NewVs,NewCs,[[(V,S1)|A]|NewLs],NewSize):-
	[H]="1",!,S1 is Size+1,
	gen_cont_line(T,V,S1,OldVs,OldCs,R,NewVs,NewCs,NewLs,NewSize).
gen_cont_line([(V1,C1)|T],V,Size,OldVs,OldCs,[A|R],NewVs,[sl(V1,C1,V,S1)|NewCs], [[(V1,C1)|A]|NewLs],NewSize):-
	!,S1 is Size+1,
	gen_cont_line(T,V,S1,OldVs,OldCs,R,NewVs,NewCs,NewLs,NewSize).
gen_cont_line([],_,Size,Vs,Cs,[],Vs,Cs,[],Size).

% pretty print of solved puzzle
pl([L|T]):-
 ([L]="0" -> write(0)
           ; (L=(V,P),mem(C,V,P), put(C)) ),
	pl(T).
pp([H|T]):-
	pl(H),pp(T).
pp([]):-nl.

pl([L|T]):-
 L=(V,P),mem(C,V,P), put(C),
	pl(T).
pl([]):-nl.