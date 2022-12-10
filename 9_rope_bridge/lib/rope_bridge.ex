defmodule RopeBridge do
  def count_visited(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{head: {0, 0}, tail: {0, 0}, visited: MapSet.new([{0, 0}])}, &move/2)
    |> Map.get(:visited)
    |> MapSet.size()
  end

  defp parse_line(<<dir::bytes-size(1)>> <> " " <> dist), do: {dir, String.to_integer(dist)}

  defp move({dir, dist}, state) do
    Enum.reduce(1..dist, state, fn _, state -> step(dir, state) end)
  end

  defp step(dir, state) do
    head = move_head(state.head, dir)
    tail = move_tail(state.tail, head)

    state
    |> Map.put(:head, head)
    |> Map.put(:tail, tail)
    |> Map.update!(:visited, &MapSet.put(&1, tail))
  end

  defp move_head({x, y}, "U"), do: {x, y + 1}
  defp move_head({x, y}, "D"), do: {x, y - 1}
  defp move_head({x, y}, "L"), do: {x - 1, y}
  defp move_head({x, y}, "R"), do: {x + 1, y}

  def move_tail({_tx, ty}, {hx, hy}) when hy - ty == 2, do: {hx, ty + 1}
  def move_tail({_tx, ty}, {hx, hy}) when hy - ty == -2, do: {hx, ty - 1}
  def move_tail({tx, _ty}, {hx, hy}) when hx - tx == 2, do: {tx + 1, hy}
  def move_tail({tx, _ty}, {hx, hy}) when hx - tx == -2, do: {tx - 1, hy}
  def move_tail(tail, _head), do: tail
end
