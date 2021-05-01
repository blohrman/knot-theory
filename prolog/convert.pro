% First section of rules defines the main functionality of gauss code conversion.
generate(Str, Out) :-
  parseStringToArr(Str, Arr),
  pairElems(Arr, Pairs),
  generateGauss(Pairs, Code),
  convertArrToStr(Code, Out).

generateGauss(Pairs, Out) :- 
  length(Pairs, N),
  Length is N * 2,
  zeroes(Length, Arr),
  gaussHelper(Pairs, 1, 1, Arr, Out).

gaussHelper([Pair], Crossing, _, List, Out) :- replaceWithCrossing(Pair, Crossing, List, Out).
gaussHelper(Pairs, Crossing, Index, List, Out) :- 
  findPair(Pairs, Index, Pair), findIndex(Pairs, Index, FoundIndex) ->  
  (
    replaceWithCrossing(Pair, Crossing, List, NewList),
    delFromList(Pairs, FoundIndex, NewPairs),
    NewCrossing is Crossing + 1, 
    NewIndex is Index + 1,
    gaussHelper(NewPairs, NewCrossing, NewIndex, NewList, Out)
  ) ;
  length(List, Len), Index =< Len,
  NewIndex is Index + 1, 
  gaussHelper(Pairs, Crossing, NewIndex, List, Out).


% Second Section here defines key helper rules.
pair(X, Y, [X, Y]).

pairElems(Nums, Pairs) :- pairHelper(Nums, 1, Pairs).

pairHelper([Num], OddNum, [[Num, OddNum]]).
pairHelper([Val|Vals], OddNum, [Pair|Pairs]) :- 
  pair(Val, OddNum, Pair), 
  NextNum is OddNum + 2,
  pairHelper(Vals, NextNum, Pairs).

replaceWithCrossing(Pair, Crossing, List, Out) :- 
  nth0(0, Pair, First), FirstIndex is First - 1,
  nth0(1, Pair, Second), SecondIndex is Second - 1,
  replace(List, FirstIndex, Crossing, FirstList),
  replace(FirstList, SecondIndex, Crossing, Out).


% Third section is utility rules required by the previous sections.
parseStringToArr(Str, Out) :- 
  split_string(Str, " ", "", Nums),
  parseHelper(Nums, Out).

parseHelper([Num], [Out]) :- atom_number(Num, Out).
parseHelper([Num|Nums], [Out|Outs]) :- atom_number(Num, Out), parseHelper(Nums, Outs).

convertArrToStr(Arr, Str) :-
convertHelper(Arr, Str).
  
convertHelper([Num], Out) :- number_string(Num, Out).
convertHelper([Num|Nums], Out) :- 
  number_string(Num, Str),
  string_concat(Str, " ", StrSpace),
  convertHelper(Nums, Outs), 
  string_concat(StrSpace, Outs, Out).

zeroes(Num, Out) :- findall(0, between(1, Num, _), Out).

replace([_|T], 0, X, [X|T]).
replace([H|T], Index, Val, [H|Rest]) :-
  NewIndex is Index - 1,
  replace(T, NewIndex, Val, Rest).

delFromList(List, Index, Out) :- nth0(Index, List, _, Out).

findPair(Pairs, Num, Pair) :-
  findIndex(Pairs, Num, Index),
  nth0(Index, Pairs, Pair).

findIndex([Pair|_], Num, 0) :- member(Num, Pair), !.
findIndex([_|Pairs], Num, Index) :- 
  findIndex(Pairs, Num, NewIndex),
  Index is NewIndex + 1.