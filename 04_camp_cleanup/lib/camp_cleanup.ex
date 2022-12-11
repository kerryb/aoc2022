defmodule CampCleanup do
  def count_fully_covered(input) do
    input |> parse() |> Enum.count(&fully_covered?/1)
  end

  def count_overlapping(input) do
    input |> parse() |> Enum.count(&overlapping?/1)
  end

  defp parse(input) do
    ~r/^(\d+)-(\d+),(\d+)-(\d+)$/m
    |> Regex.scan(input, capture: :all_but_first)
    |> Enum.map(fn matches -> Enum.map(matches, &String.to_integer/1) end)
  end

  defp fully_covered?([a_1, b_1, a_2, b_2]) when a_1 >= a_2 and b_1 <= b_2, do: true
  defp fully_covered?([a_1, b_1, a_2, b_2]) when a_2 >= a_1 and b_2 <= b_1, do: true
  defp fully_covered?(_), do: false

  defp overlapping?([_a_1, b_1, a_2, _b_2]) when b_1 < a_2, do: false
  defp overlapping?([a_1, _b_1, _a_2, b_2]) when b_2 < a_1, do: false
  defp overlapping?(_), do: true
end
