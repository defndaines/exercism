defmodule PigLatin do
  @vowels ~w(a e i o u y)

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map_join(" ", fn chunk ->
      chunk
      |> String.graphemes()
      |> Enum.split_while(&(&1 not in @vowels))
      |> to_latin()
      |> Enum.join()
    end)
  end

  defp to_latin({[], ["y", ch | _] = v}) when ch in @vowels, do: [tl(v), "yay"]
  defp to_latin({c, ["y" | _] = v}), do: [v, c, "ay"]
  defp to_latin({["x", "r"], v}), do: ["xr", v, "ay"]

  defp to_latin({c, ["u" | v]}) do
    if List.last(c) == "q" do
      [v, c, "uay"]
    else
      ["u", v, c, "ay"]
    end
  end

  defp to_latin({c, v}), do: [v, c, "ay"]
end
