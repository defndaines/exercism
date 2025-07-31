defmodule Rectangles do
  @doc """
  Count the number of ASCII rectangles.
  """
  @spec count(input :: String.t()) :: integer
  def count(input) do
    corners =
      for {row, y} <- input |> String.split("\n") |> Enum.with_index(),
          {v, x} <- row |> String.graphemes() |> Enum.with_index(),
          v == "+" do
        {x, y}
      end

    rectangles(corners)
  end

  defp rectangles([]), do: 0

  defp rectangles([{x, y} | rest]) do
    rest
    |> Enum.filter(&match?({^x, _}, &1))
    |> Enum.reduce(0, fn {^x, b}, total ->
      rest
      |> Enum.filter(&match?({_, ^y}, &1))
      |> Enum.reduce(0, fn {a, ^y}, acc ->
        if Enum.member?(rest, {a, b}), do: acc + 1, else: acc
      end)
      |> Kernel.+(total)
    end)
    |> Kernel.+(rectangles(rest))
  end
end
