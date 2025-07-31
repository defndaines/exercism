-module(roman_numerals).

-export([numerals/1]).

-define(ROMAN_NUMERALS,
        [ {1000, "M"}, {900, "CM"}, {500, "D"}, {400, "CD"}
        , {100, "C"}, {90, "XC"}, {50, "L"}, {40, "XL"}
        , {10, "X"}, {9, "IX"}, {5, "V"}, {4, "IV"}
        , {1, "I"} ]).

-spec numerals(non_neg_integer()) -> string().
numerals(Number) ->
  numerals(Number, ?ROMAN_NUMERALS).

numerals(0, _Romans) ->
  "";
numerals(N, [{Arab, Roman} | Tail]) when N >= Arab ->
  Roman ++ numerals(N - Arab, [{Arab, Roman} | Tail]);
numerals(N, [_Head | Tail]) ->
  numerals(N, Tail).