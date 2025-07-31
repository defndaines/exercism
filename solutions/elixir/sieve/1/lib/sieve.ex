defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit, acc \\ []) do
    primes(Enum.to_list(2..limit), [])
  end

  defp primes([], acc), do: Enum.reverse(acc)
  defp primes([n | rest], acc) do
    primes(Enum.reject(rest, &(rem(&1, n) == 0)), [n | acc])
  end
end
