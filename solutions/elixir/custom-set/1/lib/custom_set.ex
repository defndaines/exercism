defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}

  defstruct map: %{}

  @spec new(Enum.t()) :: t
  def new(enumerable), do: %__MODULE__{map: Enum.reduce(enumerable, %{}, &Map.put(&2, &1, nil))}

  @spec empty?(t) :: boolean
  def empty?(%{map: map}), do: map |> Map.keys() |> Enum.empty?()

  @spec contains?(t, any) :: boolean
  def contains?(%{map: map}, element), do: Map.has_key?(map, element)

  @spec subset?(t, t) :: boolean
  def subset?(%{map: set_1}, %{map: set_2}), do: Map.keys(set_1) -- Map.keys(set_2) == []

  @spec disjoint?(t, t) :: boolean
  def disjoint?(%{map: set_1}, %{map: set_2}) do
    keys_1 = Map.keys(set_1)
    keys_1 -- Map.keys(set_2) == keys_1
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2), do: custom_set_1 == custom_set_2

  @spec add(t, any) :: t
  def add(custom_set, element) do
    %__MODULE__{custom_set | map: Map.put(custom_set.map, element, nil)}
  end

  @spec intersection(t, t) :: t
  def intersection(%{map: set_1}, %{map: set_2}) do
    keys_2 = Map.keys(set_2)
    set_1 |> Map.keys() |> Enum.filter(&(&1 in keys_2)) |> new()
  end

  @spec difference(t, t) :: t
  def difference(%{map: set_1}, %{map: set_2}), do: new(Map.keys(set_1) -- Map.keys(set_2))

  @spec union(t, t) :: t
  def union(%{map: set_1}, %{map: set_2}), do: new(Map.keys(set_1) ++ Map.keys(set_2))
end
