defmodule VariableLengthQuantity do
  import Bitwise

  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode(integers) do
    [i] = integers
    IO.inspect(i, label: :i)
    do_encode(i)
  end

  defp do_encode(_, acc \\ <<0>>)
  defp do_encode(0, acc), do: acc

  defp do_encode(i, acc) do
    IO.inspect(band(i, 127), label: :band)
    IO.inspect(bsr(i, 7), label: :bsr)
    do_encode(bsr(i, 7), <<band(i, 127)::7, acc>>)
  end

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes) do
  end
end
