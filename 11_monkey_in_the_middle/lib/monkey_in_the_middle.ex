defmodule MonkeyInTheMiddle do
  alias MonkeyInTheMiddle.Monkey

  def run(input), do: run(input, 20, &div(&1, 3))
  def run_long(input), do: run(input, 10000, & &1)

  defp run(input, rounds, worry_reducer) do
    %{monkeys: Monkey.parse(input), rounds_remaining: rounds, next_monkey: 0}
    |> play(worry_reducer)
    |> Map.get(:monkeys)
    |> Map.values()
    |> Enum.map(& &1.inspect_count)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.reduce(&Kernel.*/2)
  end

  defp play(%{rounds_remaining: 0} = state, _), do: state

  defp play(state, worry_reducer) do
    case Monkey.throw(state.monkeys[state.next_monkey], worry_reducer) do
      :no_items ->
        if state.next_monkey == state.monkeys |> Map.keys() |> Enum.max() do
          state |> Map.update!(:rounds_remaining, &(&1 - 1)) |> Map.put(:next_monkey, 0)
        else
          state |> Map.update!(:next_monkey, &(&1 + 1))
        end

      {monkey, item, throw_to} ->
        state
        |> put_in([:monkeys, state.next_monkey], monkey)
        |> update_in([:monkeys, throw_to], &add_item(&1, item))
    end
    |> play(worry_reducer)
  end

  defp add_item(monkey, item) do
    Map.update!(monkey, :items, &(&1 ++ [item]))
  end
end
