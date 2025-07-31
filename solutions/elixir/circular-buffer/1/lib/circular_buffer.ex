defmodule CircularBuffer do
  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  use GenServer

  defstruct [:buffer, :capacity, head: 0, tail: 0]

  ## API

  @doc """
  Create a new buffer of a given capacity
  """
  @spec new(capacity :: integer) :: {:ok, pid}
  def new(capacity), do: GenServer.start(__MODULE__, capacity)

  @doc """
  Read the oldest entry in the buffer, fail if it is empty
  """
  @spec read(buffer :: pid) :: {:ok, any} | {:error, atom}
  def read(buffer), do: GenServer.call(buffer, :read)

  @doc """
  Write a new item in the buffer, fail if is full
  """
  @spec write(buffer :: pid, item :: any) :: :ok | {:error, atom}
  def write(buffer, item), do: GenServer.call(buffer, {:write, item})

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(buffer :: pid, item :: any) :: :ok
  def overwrite(buffer, item), do: GenServer.call(buffer, {:overwrite, item})

  @doc """
  Clear the buffer
  """
  @spec clear(buffer :: pid) :: :ok
  def clear(buffer), do: GenServer.call(buffer, :clear)

  ## GenServer

  @impl GenServer
  def init(capacity) do
    {:ok, %__MODULE__{capacity: capacity, buffer: %{}}}
  end

  @impl GenServer
  def handle_call(:read, _, state) do
    case Map.pop(state.buffer, state.head) do
      {nil, _} ->
        {:reply, {:error, :empty}, state}

      {value, buffer} ->
        {:reply, {:ok, value},
         %{state | buffer: buffer, head: rem(state.head + 1, state.capacity)}}
    end
  end

  def handle_call({:write, item}, _, state) do
    if Map.has_key?(state.buffer, state.tail) do
      {:reply, {:error, :full}, state}
    else
      {:reply, :ok,
       %{
         state
         | buffer: Map.put(state.buffer, state.tail, item),
           tail: rem(state.tail + 1, state.capacity)
       }}
    end
  end

  def handle_call({:overwrite, item}, _, state) do
    {:reply, :ok,
     %{
       state
       | buffer: Map.put(state.buffer, state.tail, item),
         tail: rem(state.tail, state.capacity)
     }}
  end

  def handle_call(:clear, _, state), do: {:reply, :ok, %{state | buffer: %{}}}
end
