defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a) do
    :equal
  end
  def compare([], _) do
    :sublist
  end
  def compare(_, []) do
    :superlist
  end
  def compare(a, b) when (length a) > (length b) do
    if Enum.any?(Enum.chunk(a, (length b), 1), &(&1 === b)) do
      :superlist
    else
      :unequal
    end
  end
  def compare(a, b) when (length b) > (length a) do
    if Enum.any?(Enum.chunk(b, (length a), 1), &(&1 === a)) do
      :sublist
    else
      :unequal
    end
  end
  def compare(_, _) do
    :unequal
  end
end