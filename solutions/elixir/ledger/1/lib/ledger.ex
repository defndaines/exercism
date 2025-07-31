defmodule Ledger do
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @column_separator " | "

  defp format_header(locale) do
    [date, desc, change] =
      if locale == :en_US,
        do: ~w(Date Description Change),
        else: ~w(Datum Omschrijving Verandering)

    Enum.join(
      [
        String.pad_trailing(date, 10, " "),
        String.pad_trailing(desc, 25, " "),
        String.pad_trailing(change, 13, " ")
      ],
      @column_separator
    ) <> "\n"
  end

  @doc """
  Format the given entries given a currency and locale
  """
  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(currency, locale, entries) do
    header = format_header(locale)

    if entries == [] do
      header
    else
      entries =
        entries
        |> Enum.sort_by(&{&1.date.day, &1.description, &1.amount_in_cents})
        |> Enum.map_join("\n", fn entry -> format_entry(currency, locale, entry) end)

      header <> entries <> "\n"
    end
  end

  defp format_entry(currency, locale, entry) do
    date_format = if locale == :en_US, do: "%m/%d/%Y", else: "%d-%m-%Y"
    date = Calendar.strftime(entry.date, date_format)

    description =
      if String.length(entry.description) > 26 do
        String.slice(entry.description, 0, 22) <> "..."
      else
        String.pad_trailing(entry.description, 25, " ")
      end

    amount = format_money(currency, locale, entry.amount_in_cents) |> String.pad_leading(13, " ")

    Enum.join([date, description, amount], @column_separator)
  end

  defp format_money(currency, locale, cents) do
    {dec_sep, thou_sep} = if locale == :en_US, do: {".", ","}, else: {",", "."}
    whole = cents |> abs() |> div(100) |> format_integer(thou_sep)
    decimal = cents |> abs() |> rem(100) |> to_string() |> String.pad_leading(2, "0")
    number = whole <> dec_sep <> decimal
    currency_symbol = if currency == :eur, do: "€", else: "$"

    case {locale, cents >= 0} do
      {:en_US, true} -> "#{currency_symbol}#{number} "
      {:en_US, false} -> "(#{currency_symbol}#{number})"
      {_, true} -> "#{currency_symbol} #{number} "
      {_, false} -> "#{currency_symbol} -#{number} "
    end
  end

  defp format_integer(n, separator) when n < 1000, do: "#{n}"

  defp format_integer(n, separator) do
    "#{div(n, 1000)}" <> separator <> format_integer(rem(n, 1000), separator)
  end
end
