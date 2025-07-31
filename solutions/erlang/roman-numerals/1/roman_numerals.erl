-module(roman_numerals).

-export([numerals/1]).

-spec numerals(non_neg_integer()) -> string().
numerals(Number) ->
  AsString = integer_to_list(Number),
  numerals(AsString, length(AsString), "").

numerals([C | Rest], 4, Acc) ->
  numerals(Rest, 3, Acc ++ string:copies("M", C - $0));
numerals([$9 | Rest], 3, Acc) ->
  numerals(Rest, 2, Acc ++ "CM");
numerals([$4 | Rest], 3, Acc) ->
  numerals(Rest, 2, Acc ++ "CD");
numerals([C | Rest], 3, Acc) when C > $4 ->
  numerals(Rest, 2, Acc ++ "D" ++ string:copies("C", C - $5));
numerals([C | Rest], 3, Acc) ->
  numerals(Rest, 2, Acc ++ string:copies("C", C - $0));
numerals([$9 | Rest], 2, Acc) ->
  numerals(Rest, 1, Acc ++ "XC");
numerals([$4 | Rest], 2, Acc) ->
  numerals(Rest, 1, Acc ++ "XL");
numerals([C | Rest], 2, Acc) when C > $4 ->
  numerals(Rest, 1, Acc ++ "L" ++ string:copies("X", C - $5));
numerals([C | Rest], 2, Acc) ->
  numerals(Rest, 1, Acc ++ string:copies("X", C - $0));
numerals([$9], 1, Acc) ->
  Acc ++ "IX";
numerals([$4], 1, Acc) ->
  Acc ++ "IV";
numerals([C], 1, Acc) when C > $4 ->
  Acc ++ "V" ++ string:copies("I", C - $5);
numerals([C], 1, Acc) ->
  Acc ++ string:copies("I", C - $0).