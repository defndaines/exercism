-module(grains).
-export([square/1, total/0]).

square(Position) ->
  square(Position, 1).

square(1, Acc) ->
  Acc;
square(Position, Acc) ->
  square(Position - 1, Acc * 2).

total() ->
  lists:sum([square(G) || G <- lists:seq(1, 64)]).