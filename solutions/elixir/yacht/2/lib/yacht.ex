defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(:yacht, [n, n, n, n, n]), do: 50
  def score(:choice, dice), do: Enum.sum(dice)
  def score(:ones, dice), do: dice |> Enum.filter(&(&1 == 1)) |> Enum.sum()
  def score(:twos, dice), do: dice |> Enum.filter(&(&1 == 2)) |> Enum.sum()
  def score(:threes, dice), do: dice |> Enum.filter(&(&1 == 3)) |> Enum.sum()
  def score(:fours, dice), do: dice |> Enum.filter(&(&1 == 4)) |> Enum.sum()
  def score(:fives, dice), do: dice |> Enum.filter(&(&1 == 5)) |> Enum.sum()
  def score(:sixes, dice), do: dice |> Enum.filter(&(&1 == 6)) |> Enum.sum()

  def score(:four_of_a_kind, dice) do
    case dice |> Enum.sort() |> Enum.chunk_by(& &1) do
      [[_], [x, x, x, x]] -> x * 4
      [[x, x, x, x], [_]] -> x * 4
      [[x, x, x, x, x]] -> x * 4
      _ -> 0
    end
  end

  def score(:full_house, dice) do
    case dice |> Enum.sort() |> Enum.chunk_by(& &1) do
      [[x, x], [y, y, y]] -> Enum.sum(dice)
      [[x, x, x], [y, y]] -> Enum.sum(dice)
      _ -> 0
    end
  end

  def score(:little_straight, dice) do
    if dice |> Enum.sort() == [1, 2, 3, 4, 5], do: 30, else: 0
  end

  def score(:big_straight, dice) do
    if dice |> Enum.sort() == [2, 3, 4, 5, 6], do: 30, else: 0
  end

  def score(_, _), do: 0
end
