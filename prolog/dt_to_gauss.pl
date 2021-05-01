:- use_module(util).

% First section of rules defines the main functionality of gauss code conversion.
generate(Str, Out) :-
  parse_string_to_arr(Str, Arr),
  pair_elems(Arr, Pairs),
  generate_gauss(Pairs, Code),
  arr_to_str(Code, Out).

generate_gauss(Pairs, Out) :- 
  length(Pairs, N),
  Length is N * 2,
  zeroes(Length, Arr),
  gauss_helper_(Pairs, 1, 1, Arr, Out).

gauss_helper_([Pair], Crossing, _, List, Out) :- replace_with_crossing(Pair, Crossing, List, Out).
gauss_helper_(Pairs, Crossing, Index, List, Out) :- 
  find_pair(Pairs, Index, Pair), find_index(Pairs, Index, FoundIndex) ->  
  (
    replace_with_crossing(Pair, Crossing, List, NewList),
    del_from_list(Pairs, FoundIndex, NewPairs),
    NewCrossing is Crossing + 1, 
    NewIndex is Index + 1,
    gauss_helper_(NewPairs, NewCrossing, NewIndex, NewList, Out)
  ) ;
  length(List, Len), Index =< Len,
  NewIndex is Index + 1, 
  gauss_helper_(Pairs, Crossing, NewIndex, List, Out).


% Second Section here defines key helper rules.
pair(X, Y, [X, Y]).

pair_elems(Nums, Pairs) :- pair_helper_(Nums, 1, Pairs).

pair_helper_([Num], OddNum, [[Num, OddNum]]).
pair_helper_([Val|Vals], OddNum, [Pair|Pairs]) :- 
  pair(Val, OddNum, Pair), 
  NextNum is OddNum + 2,
  pair_helper_(Vals, NextNum, Pairs).

replace_with_crossing(Pair, Crossing, List, Out) :- 
  nth0(0, Pair, First), FirstIndex is First - 1,
  nth0(1, Pair, Second), SecondIndex is Second - 1,
  replace(List, FirstIndex, Crossing, FirstList),
  replace(FirstList, SecondIndex, Crossing, Out).