:- module(util, [parse_string_to_arr/2, arr_to_str/2, zeroes/2, replace/4, del_from_list/3, find_pair/3, find_index/3]).

parse_string_to_arr(Str, Out) :- 
  split_string(Str, " ", "", Nums),
  parse_helper_(Nums, Out).

parse_helper_([Num], [Out]) :- atom_number(Num, Out).
parse_helper_([Num|Nums], [Out|Outs]) :- atom_number(Num, Out), parse_helper_(Nums, Outs).

arr_to_str(Arr, Str) :-
  convert_helper_(Arr, Str).
  
convert_helper_([Num], Out) :- number_string(Num, Out).
convert_helper_([Num|Nums], Out) :- 
  number_string(Num, Str),
  string_concat(Str, " ", StrSpace),
  convert_helper_(Nums, Outs), 
  string_concat(StrSpace, Outs, Out).

zeroes(Num, Out) :- findall(0, between(1, Num, _), Out).

replace([_|T], 0, X, [X|T]).
replace([H|T], Index, Val, [H|Rest]) :-
  NewIndex is Index - 1,
  replace(T, NewIndex, Val, Rest).

del_from_list(List, Index, Out) :- nth0(Index, List, _, Out).

find_pair(Pairs, Num, Pair) :-
  find_index(Pairs, Num, Index),
  nth0(Index, Pairs, Pair).

find_index([Pair|_], Num, 0) :- member(Num, Pair), !.
find_index([_|Pairs], Num, Index) :- 
  find_index(Pairs, Num, NewIndex),
  Index is NewIndex + 1.