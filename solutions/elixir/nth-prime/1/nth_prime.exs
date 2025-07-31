defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(1), do: 2
  def nth(count) when count > 1 do
    Stream.iterate(3, &(&1 + 2))
    |> Stream.scan([], &prime?/2)
    |> Stream.take_while(&(length(&1) < count))
    |> Enum.at(-1)
    |> List.first
  end

  defp prime?(test, known) do
    if Enum.any?(known, &(rem(test, &1) == 0)) do
      known
    else
      [test | known]
    end
  end
end