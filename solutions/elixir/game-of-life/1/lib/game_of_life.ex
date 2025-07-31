defmodule GameOfLife do
  @doc """
  Apply the rules of Conway's Game of Life to a grid of cells
  """

  @spec tick(matrix :: list(list(0 | 1))) :: list(list(0 | 1))
  def tick([]), do: []

  def tick(matrix) do
    map = step(matrix)

    for x <- 0..(length(matrix) - 1) do
      for y <- 0..(length(hd(matrix)) - 1), do: Map.get(map, {x, y})
    end
  end

  defp to_map(matrix) do
    matrix
    |> Enum.with_index(fn row, x -> Enum.with_index(row, fn live, y -> {{x, y}, live} end) end)
    |> List.flatten()
    |> Map.new()
  end

  defp neighbors(map, {x, y}) do
    [
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},
      {x, y - 1},
      {x, y + 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1}
    ]
    |> Enum.reduce([], fn e, acc -> if Map.get(map, e) == 1, do: [1 | acc], else: acc end)
    |> length()
  end

  defp step(matrix) do
    map = to_map(matrix)

    Enum.reduce(map, %{}, fn {pos, live}, acc ->
      Map.put(acc, pos, alive(live, neighbors(map, pos)))
    end)
  end

  defp alive(1, neighbors) when neighbors in 2..3, do: 1
  defp alive(0, 3), do: 1
  defp alive(_, _), do: 0
end
