defmodule CryptoSquare do
  @alphabet ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9)

  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    str
    |> String.downcase()
    |> String.graphemes()
    |> Enum.filter(&(&1 in @alphabet))
    |> to_square()
  end

  defp to_square([]), do: ""
  # defp to_square([ch]), do: "#{ch}"

  defp to_square(crypto) do
    width = crypto |> length() |> :math.sqrt() |> ceil()

    crypto
    |> pad(width)
    |> Enum.chunk_every(width)
    |> Enum.zip()
    |> Enum.map_join(" ", &(&1 |> Tuple.to_list() |> to_string()))
  end

  defp pad(crypto, width) when rem(length(crypto), width) == 0, do: crypto

  defp pad(crypto, width) do
    crypto ++ ([" "] |> Stream.cycle() |> Enum.take(width - rem(length(crypto), width)))
  end
end
