defmodule SgfParsing do
  defmodule Sgf do
    defstruct properties: %{}, children: []
  end

  @type sgf :: %Sgf{properties: map, children: [sgf]}

  @doc """
  Parse a string into a Smart Game Format tree
  """
  @spec parse(encoded :: String.t()) :: {:ok, sgf} | {:error, String.t()}
  def parse(encoded) do
    case encoded |> String.to_charlist() |> do_parse() do
      %Sgf{} = parsed -> {:ok, %{parsed | children: Enum.reverse(parsed.children)}}
      error -> error
    end
  end

  defp do_parse(encoded, context \\ nil, acc \\ nil)

  defp do_parse([], _, nil), do: {:error, "tree missing"}
  defp do_parse([], _, acc), do: acc
  defp do_parse([?( | encoded], nil, acc), do: do_parse(encoded, {0, [], nil}, acc)
  defp do_parse([?( | encoded], context, acc), do: do_parse(encoded, context, acc)
  defp do_parse([?) | _], {0, [], nil}, _), do: {:error, "tree with no nodes"}
  defp do_parse([?) | encoded], context, acc), do: do_parse(encoded, context, acc)

  defp do_parse([?; | encoded], {level, _, nil}, acc) do
    case Enum.split_while(encoded, &(&1 != ?[)) do
      {[?)], _} ->
        %Sgf{}

      {_, []} ->
        {:error, "properties without delimiter"}

      {key, rest} ->
        if Enum.all?(key, &(&1 in ?A..?Z)) do
          sgf = if(level == 0, do: %Sgf{}, else: %{acc | children: [%Sgf{} | acc.children]})
          do_parse(rest, {level + 1, to_string(key), nil}, sgf)
        else
          {:error, "property must be in uppercase"}
        end
    end
  end

  defp do_parse([?[ | encoded], {level, key, nil}, acc) do
    {value, rest} = in_bracket(encoded)
    do_parse(rest, {level, key, nil}, update_state(acc, key, value, level))
  end

  defp do_parse([ch | encoded], {level, _, nil}, acc) do
    {key, rest} = Enum.split_while(encoded, &(&1 != ?[))

    cond do
      Enum.all?(key, &(&1 in ?A..?Z)) -> do_parse(rest, {level, to_string([ch | key]), nil}, acc)
      true -> {:error, "property must be in uppercase"}
    end
  end

  defp do_parse(_, nil, _), do: {:error, "tree missing"}

  defp in_bracket(encoded) do
    {value, rest} = Enum.split_while(encoded, &(&1 != ?]))

    cond do
      Enum.take(value, -2) == [?\\, ?\\] ->
        {Enum.drop(value, -1), tl(rest)}

      List.last(value) == ?\\ ->
        {more, tail} = rest |> tl() |> in_bracket()
        {[Enum.drop(value, -1) | [?] | more]], tail}

      true ->
        {value, tl(rest)}
    end
  end

  defp update_state(state, key, value, 1) do
    value = normalize_value(value)
    %{state | properties: Map.update(state.properties, key, [value], &(&1 ++ [value]))}
  end

  defp update_state(state, key, value, _) do
    value = normalize_value(value)
    [active | rest] = state.children
    child = %{active | properties: Map.update(active.properties, key, [value], &[value | &1])}
    %{state | children: [child | rest]}
  end

  defp normalize_value(value) do
    value
    |> to_string()
    |> String.replace(~r/\\*\t/, " ")
    |> String.replace("\\\n", "")
    |> String.replace("\\\\", "\\")
    |> String.replace("\\t", "t")
    |> String.replace("\\n", "n")
  end
end
