defmodule TopSecret do
  def to_ast(string) do
    {:ok, quoted} = Code.string_to_quoted(string)
    quoted
  end

  def decode_secret_message_part({op, _meta, args} = ast, acc) when op in [:def, :defp] do
    {fn_name, fn_args} =
      case args do
        [{:when, _, [{fun, _, fn_args} | _]} | _] -> {fun, fn_args}
        [{fun, _, fn_args} | _] -> {fun, fn_args}
      end

    secret =
      if fn_args do
        String.slice(to_string(fn_name), 0, length(fn_args))
      else
        ""
      end

    {ast, [secret | acc]}
  end

  def decode_secret_message_part({_, _, args} = ast, acc) when is_list(args) do
    {ast,
     Enum.reduce(args, acc, fn e, acc ->
       {_ast, acc} = decode_secret_message_part(e, acc)
       acc
     end)}
  end

  def decode_secret_message_part([do: block] = ast, acc) do
    {_, acc} = decode_secret_message_part(block, acc)
    {ast, acc}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    ast = to_ast(string)
    {^ast, acc} = decode_secret_message_part(ast, [])
    acc |> Enum.reverse() |> Enum.join()
  end
end
