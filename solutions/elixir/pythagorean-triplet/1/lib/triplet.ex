defmodule Triplet do
  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet), do: Enum.sum(triplet)

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet), do: Enum.product(triplet)

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]), do: a ** 2 + b ** 2 == c ** 2

  @doc """
  Generates a list of pythagorean triplets whose values add up to a given sum.
  """
  @spec generate(non_neg_integer) :: [list(non_neg_integer)]
  def generate(sum) do
    half = div(sum, 2)

    for a <- 1..(half - 2),
        b <- (a + 1)..(half - 1),
        c <- (b + 1)..half,
        triplet = [a, b, c],
        sum(triplet) == sum,
        pythagorean?(triplet),
        do: [a, b, c]
  end
end
