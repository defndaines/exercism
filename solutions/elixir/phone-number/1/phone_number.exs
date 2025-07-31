defmodule Phone do

  @invalid_number "0000000000"

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) when is_binary(raw) do
    if String.length(raw) > 14 do
      @invalid_number
    else
      number(for d <- to_charlist(raw), ?0 <= d and d <= ?9, do: d)
    end
  end
  def number(charlist) when length(charlist) == 10 do
    to_string(charlist)
  end
  def number([?1 | charlist]) when length(charlist) == 10 do
    to_string(charlist)
  end
  def number(_) do
    @invalid_number  
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    <<area::bytes-size(3)>> <> _rest = number(raw)
    area
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    <<area::bytes-size(3)>> <> <<prefix::bytes-size(3)>> <> <<line_number::bytes-size(4)>> = number(raw)
    "(#{area}) #{prefix}-#{line_number}"
  end
end