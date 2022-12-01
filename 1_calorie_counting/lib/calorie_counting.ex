defmodule CalorieCounting do
  def highest_total(input) do
    input |> String.split("\n\n") |> Enum.map(&sum/1) |> Enum.max()
  end

  defp sum(lines) do
    lines |> String.split() |> Enum.map(&String.to_integer/1) |> Enum.sum()
  end
end
