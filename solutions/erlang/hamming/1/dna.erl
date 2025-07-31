-module(dna).
-export([hamming_distance/2]).

-spec hamming_distance(string(), string()) -> non_neg_integer().
hamming_distance(Left, Right) ->
  hamming_distance(Left, Right, 0).

-spec hamming_distance(string(), string(), non_neg_integer()) -> non_neg_integer().
hamming_distance("", "", Acc) ->
  Acc;
hamming_distance([C | Left], [C | Right], Acc) ->
  hamming_distance(Left, Right, Acc);
hamming_distance([_L | Left], [_R | Right], Acc) ->
  hamming_distance(Left, Right, Acc + 1).