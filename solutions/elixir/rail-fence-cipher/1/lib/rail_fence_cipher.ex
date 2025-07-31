defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, rails) do
    zig_zag = Stream.cycle(Range.to_list(1..rails) ++ Range.to_list((rails - 1)..2//-1))

    encoding =
      str
      |> String.graphemes()
      |> Enum.zip(zig_zag)
      |> Enum.reduce(%{}, fn {ch, pos}, acc -> Map.update(acc, pos, [ch], &(&1 ++ [ch])) end)

    Enum.map_join(1..rails, "", &to_string(encoding[&1]))
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, rails) do
    if String.length(str) < rails do
      str
    else
      zig_zag = Stream.cycle(Range.to_list(1..rails) ++ Range.to_list((rails - 1)..2//-1))

      encoding =
        Enum.zip([0..(String.length(str) - 1), zig_zag])
        |> Enum.reduce(%{}, fn {at, pos}, acc -> Map.update(acc, pos, [at], &(&1 ++ [at])) end)

      positions =
        Enum.flat_map(1..rails, &Map.get(encoding, &1))
        |> Enum.zip(String.graphemes(str))
        |> Map.new()

      0..(String.length(str) - 1)
      |> Enum.map(&Map.get(positions, &1))
      |> to_string()
    end
  end
end
