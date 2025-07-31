defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep([], _fun), do: []
  def keep(list, fun) do
    do_keep(list, [], fun)
  end

  @spec do_keep(list :: list(any), list :: list(any), fun :: (any -> boolean)) :: list(any)
  defp do_keep([], acc, _fun), do: acc
  defp do_keep([head | tail], acc, fun) do
    case fun.(head) do
      true -> do_keep(tail, acc ++ [head], fun)
      false -> do_keep(tail, acc, fun)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard([], fun), do: []
  def discard(list, fun) do
    do_discard(list, [], fun)
  end

  defp do_discard([], acc, _fun), do: acc
  defp do_discard([head | tail], acc, fun) do
    case fun.(head) do
      true -> do_discard(tail, acc, fun)
      false -> do_discard(tail, acc ++ [head], fun)
    end
  end
end
