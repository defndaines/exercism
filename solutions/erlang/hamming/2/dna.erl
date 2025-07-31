-module(dna).
-export([hamming_distance/2]).

-spec hamming_distance(string(), string()) -> non_neg_integer().
hamming_distance(Left, Right) ->
  lists:foldl(fun equal_or_inc/2, 0, lists:zip(Left, Right)).

equal_or_inc({C, C}, Acc) -> Acc;
equal_or_inc({_, _}, Acc) -> Acc + 1.