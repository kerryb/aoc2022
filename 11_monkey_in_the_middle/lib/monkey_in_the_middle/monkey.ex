defmodule MonkeyInTheMiddle.Monkey do
  defstruct [:id, :items, :operation, :divisor, :if_true, :if_false]

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce([], &parse_line/2)
    |> Enum.into(%{}, &{&1.id, &1})
  end

  defp parse_line("Monkey " <> arg, monkeys) do
    {index, _} = Integer.parse(arg)
    [%__MODULE__{id: index} | monkeys]
  end

  defp parse_line("  Starting items: " <> arg, [monkey | monkeys]) do
    items = arg |> String.split(", ") |> Enum.map(&String.to_integer/1)
    [%{monkey | items: items} | monkeys]
  end

  defp parse_line("  Operation: " <> arg, [monkey | monkeys]) do
    [%{monkey | operation: build_operation(arg)} | monkeys]
  end

  defp parse_line("  Test: divisible by " <> arg, [monkey | monkeys]) do
    [%{monkey | divisor: String.to_integer(arg)} | monkeys]
  end

  defp parse_line("    If true: throw to monkey " <> arg, [monkey | monkeys]) do
    [%{monkey | if_true: String.to_integer(arg)} | monkeys]
  end

  defp parse_line("    If false: throw to monkey " <> arg, [monkey | monkeys]) do
    [%{monkey | if_false: String.to_integer(arg)} | monkeys]
  end

  defp parse_line(_, monkeys), do: monkeys

  defp build_operation("new = old + " <> arg), do: fn x -> x + String.to_integer(arg) end
  defp build_operation("new = old * old"), do: fn x -> x * x end
  defp build_operation("new = old * " <> arg), do: fn x -> x * String.to_integer(arg) end
end
