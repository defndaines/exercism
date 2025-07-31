defmodule RobotSimulator do
  @type direction :: :north | :east | :south | :west
  @type robot :: {direction, {integer, integer}}

  @doc """
  Create a Robot Simulator given an initial direction and position.
  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: robot
  def create(direction \\ :north, position \\ {0, 0})

  def create(_direction, {x, _y}) when not is_integer(x) do
    {:error, "invalid position"}
  end

  def create(_direction, {_x, y}) when not is_integer(y) do
    {:error, "invalid position"}
  end

  def create(_direction, position) when 2 != tuple_size(position) do
    {:error, "invalid position"}
  end

  def create(_direction, position) when not is_tuple(position) do
    {:error, "invalid position"}
  end

  def create(direction, position) do
    case Enum.member?([:north, :east, :south, :west], direction) do
      true -> {direction, position}
      false -> {:error, "invalid direction"}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.
  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: robot, instructions :: charlist()) :: robot
  def simulate(robot, ""), do: robot
  def simulate(robot, <<?A, rest::binary>>), do: simulate(advance(robot), rest)
  def simulate(robot, <<?R, rest::binary>>), do: simulate(rotate(?R, robot), rest)
  def simulate(robot, <<?L, rest::binary>>), do: simulate(rotate(?L, robot), rest)
  def simulate(_robot, _invalid), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.
  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: robot) :: direction
  def direction({direction, _}), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: robot) :: {integer, integer}
  def position({_, position}), do: position

  @spec rotate(rotation :: char, robot :: robot) :: robot
  defp rotate(?R, {:north, position}), do: {:east, position}
  defp rotate(?R, {:east, position}), do: {:south, position}
  defp rotate(?R, {:south, position}), do: {:west, position}
  defp rotate(?R, {:west, position}), do: {:north, position}
  defp rotate(?L, {:north, position}), do: {:west, position}
  defp rotate(?L, {:east, position}), do: {:north, position}
  defp rotate(?L, {:south, position}), do: {:east, position}
  defp rotate(?L, {:west, position}), do: {:south, position}

  @spec advance(robot :: robot) :: robot
  defp advance({:north, {x, y}}), do: {:north, {x, y + 1}}
  defp advance({:east, {x, y}}), do: {:east, {x + 1, y}}
  defp advance({:south, {x, y}}), do: {:south, {x, y - 1}}
  defp advance({:west, {x, y}}), do: {:west, {x - 1, y}}
end
