defmodule StateOfTicTacToe do
  @wins [
    MapSet.new([1, 2, 3]),
    MapSet.new([4, 5, 6]),
    MapSet.new([7, 8, 9]),
    MapSet.new([1, 4, 7]),
    MapSet.new([2, 5, 8]),
    MapSet.new([3, 6, 9]),
    MapSet.new([1, 5, 9]),
    MapSet.new([3, 5, 7])
  ]

  @impossible {:error, "Impossible board: game should have ended after the game was won"}

  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """
  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
    state = String.graphemes(board) |> Enum.reject(&(&1 == "\n"))
    x_count = state |> Enum.filter(&(&1 == "X")) |> Enum.count()
    o_count = state |> Enum.filter(&(&1 == "O")) |> Enum.count()

    cond do
      x_count > o_count + 1 ->
        {:error, "Wrong turn order: X went twice"}

      o_count > x_count ->
        {:error, "Wrong turn order: O started"}

      true ->
        seed = %{"X" => MapSet.new(), "O" => MapSet.new(), "." => MapSet.new()}

        wins =
          Enum.zip_reduce(state, 1..9, seed, fn e, i, acc ->
            if e == ".", do: acc, else: Map.update!(acc, e, &MapSet.put(&1, i))
          end)
          |> Enum.reduce([], fn
            {".", _}, acc ->
              acc

            {ch, positions}, acc ->
              wins = Enum.filter(@wins, &MapSet.subset?(&1, positions))
              if Enum.empty?(wins), do: acc, else: [{ch, wins} | acc]
          end)

        case wins do
          [{_, [_]}] -> {:ok, :win}
          [{_, [_]} | _] -> @impossible
          [{_, [_ | _]} | _] -> {:ok, :win}
          [] -> {:ok, if(Enum.member?(state, "."), do: :ongoing, else: :draw)}
        end
    end
  end
end
