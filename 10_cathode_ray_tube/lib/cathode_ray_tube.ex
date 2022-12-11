defmodule CathodeRayTube do
  def result(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(init(), &exec/2)
    |> Map.get(:result)
  end

  defp init, do: %{cycle: 1, x: 1, result: 0}

  defp exec("noop", state) do
    state
    |> tick()
    |> update_result()
  end

  defp exec("addx " <> arg, state) do
    state
    |> tick()
    |> update_result()
    |> tick()
    |> Map.update!(:x, &(&1 + String.to_integer(arg)))
    |> update_result()
  end

  defp tick(state), do: Map.update!(state, :cycle, &(&1 + 1))

  defp update_result(state) when rem(state.cycle - 20, 40) == 0,
    do: Map.update!(state, :result, &(&1 + state.x * state.cycle))

  defp update_result(state), do: state
end
