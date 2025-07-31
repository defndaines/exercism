defmodule Username do
  @safe 'abcdefghijklmnopqrstuvwxyz_'

  def sanitize(str, acc \\ [])

  def sanitize([], acc), do: acc
  def sanitize([?ü | rest], acc), do: sanitize(rest, acc ++ 'ue')
  def sanitize([?ö | rest], acc), do: sanitize(rest, acc ++ 'oe')
  def sanitize([?ä | rest], acc), do: sanitize(rest, acc ++ 'ae')
  def sanitize([?ß | rest], acc), do: sanitize(rest, acc ++ 'ss')
  def sanitize([ch | rest], acc) when ch in @safe, do: sanitize(rest, acc ++ [ch])
  def sanitize([_ | rest], acc), do: sanitize(rest, acc)
end
