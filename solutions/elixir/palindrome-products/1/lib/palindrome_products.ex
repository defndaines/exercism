defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)
  def generate(max_factor, min_factor) when min_factor > max_factor, do: raise(ArgumentError)

  def generate(max_factor, min_factor) do
    range = min_factor..max_factor

    for(x <- range, y <- range, palindrome?(x * y), uniq: true, do: x * y)
    |> Enum.sort()
    |> to_map(range)
  end

  defp palindrome?(n) do
    digits = Integer.digits(n)
    digits == Enum.reverse(digits)
  end

  defp factors(n, i \\ 1, acc \\ [])
  defp factors(n, i, acc) when n < i * i, do: acc
  defp factors(n, i, acc) when n == i * i, do: [[i, i] | acc]
  defp factors(n, i, acc) when rem(n, i) == 0, do: factors(n, i + 1, [[i, div(n, i)] | acc])
  defp factors(n, i, acc), do: factors(n, i + 1, acc)

  defp to_map([], _), do: %{}

  defp to_map(palindromes, range) do
    Map.new(
      [hd(palindromes), List.last(palindromes)],
      fn n ->
        {n, n |> factors() |> Enum.filter(fn [a, b] -> a in range and b in range end)}
      end
    )
  end
end
