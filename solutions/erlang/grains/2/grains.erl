-module(grains).
-export([square/1, total/0]).

square(Position) ->
  round(math:pow(2, Position - 1)).

total() ->
  lists:sum([square(G) || G <- lists:seq(1, 64)]).