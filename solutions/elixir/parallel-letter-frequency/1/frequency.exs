defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, num_workers) do
    results = for text <- texts, do: frequencies(text)
    Enum.reduce(results, %{}, &merge_by_sum/2)
  end

  defp frequencies(text) do
    Regex.replace(~r/\P{L}/u, text, "")
    |> String.downcase
    |> String.codepoints
    |> Enum.group_by(&(&1))
    |> Map.new(fn {k, v} -> {k, length(v)} end)
  end

  defp merge_by_sum(left, right) do
    Map.merge(left, right, fn(_k, v1, v2) -> v1 + v2 end)
  end
end