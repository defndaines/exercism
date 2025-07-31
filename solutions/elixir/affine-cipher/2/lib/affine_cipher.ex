defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: _, b: _} = key, message) do
    if Integer.gcd(key.a, 26) == 1 do
      {:ok,
       message
       |> String.downcase()
       |> String.to_charlist()
       |> do_encode(key)
       |> Enum.chunk_every(5)
       |> Enum.join(" ")}
    else
      {:error, "a and m must be coprime."}
    end
  end

  defp do_encode([ch | rest], %{a: a, b: b} = key) when ch in ?a..?z do
    [rem(a * (ch - ?a) + b, 26) + ?a | do_encode(rest, key)]
  end

  defp do_encode([], _), do: []
  defp do_encode([ch | rest], key) when ch in ?0..?9, do: [ch | do_encode(rest, key)]
  defp do_encode([_ | rest], key), do: do_encode(rest, key)

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), encrypted :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b} = key, encrypted) do
    if Integer.gcd(key.a, 26) == 1 do
      inverse = mmi(key.a)

      {:ok,
       encrypted
       |> String.to_charlist()
       |> do_decode(key)
       |> Enum.chunk_every(5)
       |> Enum.join(" ")}
    else
      {:error, "a and m must be coprime."}
    end
  end

  defp mmi(a, i \\ 0) when rem(a * i, 26) == 1, do: i
  defp mmi(a, i \\ 0), do: mmi(a, i + 1)

  defp do_decode([ch | rest], %{a: a, b: b} = key, inverse) when ch in ?a..?z do
    [rem(inverse * (ch - ?a - b), 26) + ?a | do_decode(rest, key)]
  end

  defp do_decode([], _, _), do: []
  defp do_decode([ch | rest], key, _) when ch in ?0..?9, do: [ch | do_decode(rest, key)]
  defp do_decode([_ | rest], key, _), do: do_decode(rest, key)
end
