defmodule Say do
  @words %{
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    9 => "nine"
  }

  @tys %{2 => "twenty", 3 => "thirty", 4 => "forty", 5 => "fifty", 8 => "eighty"}

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0 or number > 999_999_999_999 do
    {:error, "number is out of range"}
  end

  def in_english(0), do: {:ok, "zero"}
  def in_english(14), do: {:ok, "fourteen"}
  def in_english(number), do: {:ok, number |> Integer.digits() |> english() |> String.trim()}

  defp english([]), do: ""
  defp english([0 | rest]), do: english(rest)

  defp english(digits) when length(digits) > 9, do: chunk(digits, 9, "billion")
  defp english(digits) when length(digits) > 6, do: chunk(digits, 6, "million")
  defp english(digits) when length(digits) > 3, do: chunk(digits, 3, "thousand")
  defp english(digits) when length(digits) > 2, do: chunk(digits, 2, "hundred")

  defp english([n, 0]), do: Map.get_lazy(@tys, n, fn -> @words[n] <> "ty" end)

  defp english([n, rest]) do
    Map.get_lazy(@tys, n, fn -> @words[n] <> "ty" end) <> "-" <> english(rest)
  end

  defp english([n]), do: @words[n]
  defp english(n), do: @words[n]

  defp chunk(digits, len, unit) do
    this_bit = length(digits) - len

    english(Enum.take(digits, this_bit)) <>
      " " <> unit <> " " <> english(Enum.drop(digits, this_bit))
  end
end
