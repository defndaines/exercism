-module(accumulate).
-export([accumulate/2]).

accumulate(Fn, []) -> [];
accumulate(Fn, [Head | Tail]) ->
  [Fn(Head) | accumulate(Fn, Tail)].