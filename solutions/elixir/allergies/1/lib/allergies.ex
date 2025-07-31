defmodule Allergies do
  import Bitwise

  @allergens ~w(eggs peanuts shellfish strawberries tomatoes chocolate pollen cats)

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    {_, allergies} =
      Enum.reduce(@allergens, {flags, []}, fn allergen, {n, acc} ->
        {bsr(n, 1), if(band(n, 1) == 1, do: [allergen | acc], else: acc)}
      end)

    allergies
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item), do: flags |> list() |> Enum.member?(item)
end
