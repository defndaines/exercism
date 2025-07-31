defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """
  use GenServer

  def init(_), do: {:ok, {:open, 0}}

  def handle_cast(_, state), do: {:noreply, state}

  def handle_call(_, _, {:closed, _} = state) do
    {:reply, {:error, :account_closed}, state}
  end
  def handle_call({:close}, _, {status, balance}) do
    {:reply, :ok, {:closed, balance}}
  end
  def handle_call({:update, amount}, _, {status, balance}) do
    {:reply, :ok, {status, balance + amount}}
  end
  def handle_call({:balance}, _, {_status, balance} = state), do: {:reply, balance, state}
  def handle_call(_, _, state) do
    {:reply, state, state}
  end

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = GenServer.start(BankAccount, nil)
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.call(account, {:close})
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    GenServer.call(account, {:balance})
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    GenServer.call(account, {:update, amount})
  end
end
