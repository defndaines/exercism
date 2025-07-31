defmodule Bob do
  def hey(input) do
    cond do
      silence? input ->
        "Fine. Be that way!"
      question? input ->
        "Sure."
      shouting? input ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end

  def shouting?(input) do
    String.upcase(input) == input and String.downcase(input) != input
  end

  def question?(input) do
    String.last(input) == "?"
  end

  def silence?(input) do
    String.trim(input) == ""
  end
end