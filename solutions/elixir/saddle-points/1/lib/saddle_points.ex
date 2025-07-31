defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(&to_int_list/1)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows()
    |> List.foldr([], &zip/2)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rows = rows(str)
    peaks = peaks(rows)
    troughs = troughs(List.foldr(rows, [], &zip/2))
    MapSet.intersection(peaks, troughs) |> MapSet.to_list()
  end

  defp to_int_list(str) do
    String.split(str)
    |> Enum.map(&String.to_integer/1)
  end

  defp zip([], []), do: []
  defp zip(first, []), do: Enum.map(first, &([&1]))
  defp zip([ch1 | rest1], [ch2 | rest2]), do: [[ch1 | ch2] | zip(rest1, rest2)]

  defp peaks(rows) do
    candidates = for x <- 0..(length(rows) - 1) do
      rows
      |> Enum.at(x)
      |> Enum.with_index()
      |> high_points(x)
    end
    candidates |> List.flatten() |> MapSet.new()
  end

  defp troughs(columns) do
    candidates = for y <- 0..(length(columns) - 1) do
      columns
      |> Enum.at(y)
      |> Enum.with_index()
      |> low_points(y)
    end
    candidates |> List.flatten() |> MapSet.new()
  end

  defp high_points(row, x) do
    max = row |> Enum.max_by(fn {v, _} -> v end) |> elem(0)
    Enum.filter(row, fn {v, _} -> v == max end)
    |> Enum.map(fn {_, y} -> {x, y} end)
  end

  defp low_points(column, y) do
    min = column |> Enum.min_by(fn {v, _} -> v end) |> elem(0)
    Enum.filter(column, fn {v, _} -> v == min end)
    |> Enum.map(fn {_, x} -> {x, y} end)
  end
end
