defmodule CalorieCounting do
  def highest_total(input), do: highest_n_total(input, 1)
  def highest_three_total(input), do: highest_n_total(input, 3)

  defp highest_n_total(input, n) do
    input
    |> String.split("\n\n")
    |> Enum.map(&sum/1)
    |> Enum.sort(:desc)
    |> Enum.take(n)
    |> Enum.sum()
  end

  defp sum(lines) do
    lines |> String.split() |> Enum.map(&String.to_integer/1) |> Enum.sum()
  end
end
