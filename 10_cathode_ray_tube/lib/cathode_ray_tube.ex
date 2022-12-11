defmodule CathodeRayTube do
  def result(input), do: run(input, 0, &update_sum/1)
  def draw(input), do: run(input, "", &draw_pixel/1)

  defp run(input, value, operation) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(init(value, operation), &exec/2)
    |> Map.get(:result)
  end

  defp init(value, operation), do: %{operation: operation, cycle: 1, x: 1, result: value}

  defp exec("noop", state) do
    state
    |> state.operation.()
    |> tick()
  end

  defp exec("addx " <> arg, state) do
    state
    |> state.operation.()
    |> tick()
    |> state.operation.()
    |> tick()
    |> Map.update!(:x, &(&1 + String.to_integer(arg)))
  end

  defp tick(state), do: Map.update!(state, :cycle, &(&1 + 1))

  defp update_sum(state) when rem(state.cycle + 20, 40) == 0 do
    Map.update!(state, :result, &(&1 + state.x * state.cycle))
  end

  defp update_sum(state), do: state

  defp draw_pixel(state) do
    column = rem(state.cycle - 1, 40)
    pixel = if abs(state.x - column) <= 1, do: "#", else: "."
    extra = if column == 39, do: "\n", else: ""
    Map.update!(state, :result, &(&1 <> pixel <> extra))
  end
end
