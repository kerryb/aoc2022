defmodule RockPaperScissors do
  def score(input) do
    input |> String.split("\n", trim: true) |> Enum.reduce(0, &(&2 + score_round(&1)))
  end

  defp score_round("A X"), do: 4
  defp score_round("A Y"), do: 8
  defp score_round("A Z"), do: 3
  defp score_round("B X"), do: 1
  defp score_round("B Y"), do: 5
  defp score_round("B Z"), do: 9
  defp score_round("C X"), do: 7
  defp score_round("C Y"), do: 2
  defp score_round("C Z"), do: 6
end
