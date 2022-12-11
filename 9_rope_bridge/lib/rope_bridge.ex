defmodule RopeBridge do
  def count_visited(input, length \\ 1) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(init_rope(length), &move/2)
    |> Map.get(:visited)
    |> MapSet.size()
  end

  defp init_rope(length) do
    %{head: {0, 0}, tails: Enum.map(1..length, fn _ -> {0, 0} end), visited: MapSet.new([{0, 0}])}
  end

  defp parse_line(<<dir::bytes-size(1)>> <> " " <> dist), do: {dir, String.to_integer(dist)}

  defp move({dir, dist}, state) do
    Enum.reduce(1..dist, state, fn _, state -> step(dir, state) end)
  end

  defp step(dir, state) do
    head = move_head(state.head, dir)
    tails = state.tails |> Enum.reduce({head, []}, &step_tail/2) |> elem(1) |> Enum.reverse()

    state
    |> Map.put(:head, head)
    |> Map.put(:tails, tails)
    |> Map.update!(:visited, &MapSet.put(&1, List.last(tails)))
  end

  defp step_tail(tail, {head, tails}) do
    tail = move_tail(tail, head)
    {tail, [tail | tails]}
  end

  defp move_head({x, y}, "U"), do: {x, y + 1}
  defp move_head({x, y}, "D"), do: {x, y - 1}
  defp move_head({x, y}, "L"), do: {x - 1, y}
  defp move_head({x, y}, "R"), do: {x + 1, y}

  def move_tail({tx, ty}, {hx, hy}) when hx - tx == 2 and hy - ty == 2, do: {tx + 1, ty + 1}
  def move_tail({tx, ty}, {hx, hy}) when hx - tx == 2 and hy - ty == -2, do: {tx + 1, ty - 1}
  def move_tail({tx, ty}, {hx, hy}) when hx - tx == -2 and hy - ty == -2, do: {tx - 1, ty - 1}
  def move_tail({tx, ty}, {hx, hy}) when hx - tx == -2 and hy - ty == 2, do: {tx - 1, ty + 1}
  def move_tail({_tx, ty}, {hx, hy}) when hy - ty == 2, do: {hx, ty + 1}
  def move_tail({_tx, ty}, {hx, hy}) when hy - ty == -2, do: {hx, ty - 1}
  def move_tail({tx, _ty}, {hx, hy}) when hx - tx == 2, do: {tx + 1, hy}
  def move_tail({tx, _ty}, {hx, hy}) when hx - tx == -2, do: {tx - 1, hy}
  def move_tail(tail, _head), do: tail
end
