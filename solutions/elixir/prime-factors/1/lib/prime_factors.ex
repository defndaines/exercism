defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number), do: do_factors(number)

  defp do_factors(n, f \\ 2, acc \\ [])
  defp do_factors(1, _, acc), do: acc

  defp do_factors(n, f, acc) do
    if rem(n, f) == 0 do
      do_factors(div(n, f), f, acc ++ [f])
    else
      do_factors(n, f + if(f > 2, do: 2, else: 1), acc)
    end
  end
end
