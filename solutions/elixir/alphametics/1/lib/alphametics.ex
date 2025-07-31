defmodule Alphametics do
  @type puzzle :: binary
  @type solution :: %{required(?A..?Z) => 0..9}

  @non_digits String.to_charlist(" =+")
  @digits [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]

  @doc """
  Takes an alphametics puzzle and returns a solution where every letter
  replaced by its number will make a valid equation. Returns `nil` when
  there is no valid solution to the given puzzle.

  ## Examples

      iex> Alphametics.solve("I + BB == ILL")
      %{?I => 1, ?B => 9, ?L => 0}

      iex> Alphametics.solve("A == B")
      nil
  """
  @spec solve(puzzle) :: solution | nil
  def solve(puzzle) do
    [left, solution] = String.split(puzzle, " == ")
    terms = String.split(left, " + ")
    non_zero = initial_chars([solution | terms])

    puzzle
    |> unique_chars()
    |> permutations(non_zero)
    |> Enum.find(fn map ->
      to_integer = fn string ->
        string |> String.to_charlist() |> Enum.map(&Map.get(map, &1)) |> Integer.undigits()
      end

      sum = terms |> Enum.map(to_integer) |> Enum.sum()
      sum == to_integer.(solution)
    end)
  end

  defp unique_chars(string) do
    string |> String.to_charlist() |> Enum.uniq() |> Enum.reject(&(&1 in @non_digits))
  end

  defp initial_chars(strings) do
    strings |> Enum.map(&(&1 |> String.to_charlist() |> List.first())) |> Enum.uniq()
  end

  defp permutations(letters, non_zero) do
    [head | tail] = letters
    seed = for n <- 1..9, do: %{head => n}

    Enum.reduce(tail, seed, fn l, acc ->
      Enum.flat_map(acc, fn map ->
        digits = @digits -- Map.values(map) -- if(Enum.member?(non_zero, l), do: [0], else: [])
        for n <- digits -- Map.values(map), do: Map.put(map, l, n)
      end)
    end)
  end
end
