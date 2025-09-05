defmodule GoCounting do
  @type position :: {integer, integer}
  @type owner :: %{owner: atom, territory: [position]}
  @type territories :: %{white: [position], black: [position], none: [position]}

  @pieces %{"_" => :none, "B" => :black, "W" => :white}

  @doc """
  Return the owner and territory around a position
  """
  @spec territory(board :: String.t(), position :: position) ::
          {:ok, owner} | {:error, String.t()}
  def territory(board, pos) do
    lines = board |> String.split() |> Enum.map(&String.graphemes/1)

    context = %{
      height: length(lines),
      width: length(hd(lines)),
      owner: nil,
      visited: MapSet.new(),
      territory: []
    }

    if in_bounds?(pos, context) do
      grid =
        for y <- 0..(context.height - 1),
            x <- 0..(context.width - 1),
            into: %{} do
          {{x, y}, @pieces[lines |> Enum.at(y) |> Enum.at(x)]}
        end

      {:ok,
       grid
       |> do_territory(pos, context)
       |> Map.take([:owner, :territory])
       |> update_in([:territory], &Enum.sort/1)}
    else
      {:error, "Invalid coordinate"}
    end
  end

  defp in_bounds?({x, y}, %{height: height, width: width}) do
    0 <= x and x < width and 0 <= y and y < height
  end

  defp neighbors(nil, _context), do: []

  defp neighbors({x, y}, context) do
    Enum.filter(
      [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}],
      &(in_bounds?(&1, context) and &1 not in context.visited)
    )
  end

  defp do_territory(_grid, nil, context), do: context

  defp do_territory(grid, pos, context) do
    case Map.get(grid, pos) do
      :black ->
        if Enum.empty?(context.territory) do
          %{owner: :none, territory: []}
        else
          case context.owner do
            :white -> %{context | owner: :none, visited: MapSet.put(context.visited, pos)}
            :none -> %{context | visited: MapSet.put(context.visited, pos)}
            _ -> %{context | owner: :black, visited: MapSet.put(context.visited, pos)}
          end
        end

      :white ->
        case context.owner do
          :black -> %{context | owner: :none, visited: MapSet.put(context.visited, pos)}
          :none -> %{context | visited: MapSet.put(context.visited, pos)}
          _ -> %{context | owner: :white, visited: MapSet.put(context.visited, pos)}
        end

      _none ->
        Enum.reduce(
          neighbors(pos, context),
          context
          |> update_in([:visited], &MapSet.put(&1, pos))
          |> update_in([:territory], &[pos | &1]),
          fn neighbor, acc -> do_territory(grid, neighbor, acc) end
        )
    end
  end

  @doc """
  Return all white, black and neutral territories
  """
  @spec territories(board :: String.t()) :: territories
  def territories(board) do
    lines = board |> String.split() |> Enum.map(&String.graphemes/1)

    context = %{
      height: length(lines),
      width: length(hd(lines)),
      owner: nil,
      visited: MapSet.new(),
      territory: []
    }

    grid =
      for y <- 0..(context.height - 1),
          x <- 0..(context.width - 1),
          into: %{} do
        {{x, y}, @pieces[lines |> Enum.at(y) |> Enum.at(x)]}
      end

    open =
      for y <- 0..(context.height - 1),
          x <- 0..(context.width - 1),
          :none == @pieces[lines |> Enum.at(y) |> Enum.at(x)] do
        {x, y}
      end

    result =
      Enum.reduce(open, %{none: [], black: [], white: []}, fn pos, acc ->
        case do_territory(grid, pos, context) do
          %{owner: owner, territory: territory} ->
            update_in(acc, [owner || :none], &(territory ++ &1))

          nil ->
            update_in(acc, [:none], &[pos | &1])
        end
      end)

    for {k, v} <- result, into: %{}, do: {k, v |> Enum.uniq() |> Enum.sort()}
  end
end
