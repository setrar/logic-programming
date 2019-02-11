/****************************/
/*       Example of         */
/* Word Puzzle Solver usage */
/*      (c) R. Bart‡k       */
/*          1996            */
/****************************/

% first consult Word Puzzle Solver (WordPuzzle.pr)
% database of words

w(7,["aaaabbb"]).
w(5,["odvar","vanba"]).
w(4,["baab","octa","arab"]).
w(3,["bnc","ara"]).
w(2,["ac","ra","na","bc"]).


solve_puzzle(["01111","01011","11110","10010","11111","11110","11010"]).