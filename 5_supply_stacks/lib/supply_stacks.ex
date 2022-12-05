defmodule SupplyStacks do
  def final_tops(input) do
    input
    |> extract_moves()
    |> Enum.reduce(initial_stacks(input), &move/2)
    |> Map.values()
    |> Enum.map(&hd/1)
    |> Enum.join()
  end

  def initial_stacks(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.take_while(&(&1 =~ ~r/\[/))
    |> Enum.map(&extract_items/1)
    |> transpose()
    |> Enum.map(fn list -> Enum.drop_while(list, &is_nil(&1)) end)
    |> Enum.with_index()
    |> Enum.into(%{}, fn {item, index} -> {index + 1, item} end)
  end

  defp extract_items(line) do
    ~r/(\[[A-Z]\]|   ) ?/
    |> Regex.scan(line, capture: :all_but_first)
    |> Enum.map(fn
      ["[" <> <<item::bytes-size(1)>> <> "]"] -> item
      _ -> nil
    end)
  end

  defp extract_moves(input) do
    ~r/^move (\d+) from (\d+) to (\d+)$/m
    |> Regex.scan(input, capture: :all_but_first)
    |> Enum.map(fn [count, from, to] ->
      %{count: String.to_integer(count), from: String.to_integer(from), to: String.to_integer(to)}
    end)
  end

  defp move(move, stacks) do
    {items, stacks} =
      Map.get_and_update!(stacks, move.from, fn stack ->
        {removed, remaining} = Enum.split(stack, move.count)
        {Enum.reverse(removed), remaining}
      end)

    Map.update!(stacks, move.to, fn stack -> items ++ stack end)
  end

  #  Stolen from https://stackoverflow.com/a/42887944/572562
  defp transpose(rows) do
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
