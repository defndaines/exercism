defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?([{n, n}]), do: true
  def chain?([{_, _}]), do: false

  def chain?(dominoes) do
    tiles = arrange(dominoes)

    cond do
      tiles == [] -> true
      {a, _} = hd(tiles) -> match?({_, ^a}, List.last(tiles))
    end
  end

  defp arrange([]), do: []
  defp arrange([tile]), do: [tile]

  defp arrange([{_, b} = tile | dominoes]) do
    case Enum.filter(dominoes, &(match?({_, ^b}, &1) or match?({^b, _}, &1))) do
      [] ->
        [{:poison, :pill}]

      matches ->
        Enum.flat_map(matches, fn
          {^b, _} = match -> [tile | arrange([match | List.delete(dominoes, match)])]
          {c, ^b} = match -> [tile | arrange([{b, c} | List.delete(dominoes, match)])]
        end)
    end
  end
end
