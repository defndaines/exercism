defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    %{
      input: input,
      pid: spawn_link(fn -> calculator.(input) end)
    }
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    # Process.flag(:trap_exit, true)
    Process.link(pid)
    Process.flag(:trap_exit, true)

    Map.put(results, input, :ok)
  end

  def reliability_check(calculator, inputs) do
    # Please implement the reliability_check/2 function
  end

  def correctness_check(calculator, inputs) do
    # Please implement the correctness_check/2 function
  end
end
