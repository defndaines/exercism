defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    1..radicand
    |> Stream.take_while(&(&1 * &1 <= radicand))
    |> Enum.to_list()
    |> List.last()
  end
end
