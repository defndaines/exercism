defmodule VariableLengthQuantity do
  import Bitwise

  @bit_mask 0b1111111

  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode(integers) do
    integers |> Enum.map(&do_encode/1) |> Enum.join(<<>>)
  end

  defp do_encode(i, flag \\ 0) do
    if band(i, @bit_mask) == i do
      <<flag::1, i::7>>
    else
      <<do_encode(bsr(i, 7), 1)::binary, flag::1, i::7>>
    end
  end

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes) do
    do_decode(bytes)
  end

  defp do_decode(bytes, acc \\ []) do
  end
end
