defmodule Treetop do
  def number_visible(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&trees_in_row(&1, false))
    |> find_visible()
    |> List.flatten()
    |> Enum.count(&elem(&1, 1))
  end

  def max_scenic_score(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&trees_in_row(&1, 1))
    |> calculate_scenic_scores()
    |> List.flatten()
    |> Enum.reduce(0, fn {_, score}, acc -> max(score, acc) end)
  end

  defp trees_in_row(row, default) do
    row
    |> String.codepoints()
    |> Enum.map(&{String.to_integer(&1), default})
  end

  defp find_visible(trees), do: four_directions(trees, &mark_visible_from_left/1)

  defp calculate_scenic_scores(trees),
    do: four_directions(trees, &multiply_each_by_visible_to_right/1)

  defp four_directions(trees, fun) do
    trees |> Enum.map(fun) |> Enum.map(fun) |> transpose() |> Enum.map(fun) |> Enum.map(fun)
  end

  # reverses order, so calling twice will check from left and right
  defp mark_visible_from_left(unchecked, checked \\ [], max_height \\ -1)
  defp mark_visible_from_left([], checked, _max_height), do: checked

  defp mark_visible_from_left([{height, _} | tail], checked, max_height)
       when height > max_height do
    mark_visible_from_left(tail, [{height, true} | checked], height)
  end

  defp mark_visible_from_left([head | tail], checked, max_height) do
    mark_visible_from_left(tail, [head | checked], max_height)
  end

  # reverses order, so calling twice will check from left and right
  defp multiply_each_by_visible_to_right(unchecked, checked \\ [])
  defp multiply_each_by_visible_to_right([], checked), do: checked

  defp multiply_each_by_visible_to_right([{height, score} | tail], checked) do
    multiply_each_by_visible_to_right(tail, [{height, score * visible(height, tail)} | checked])
  end

  defp visible(_, []), do: 0
  defp visible(height, [{head, _} | tail]) when height > head, do: 1 + visible(height, tail)
  defp visible(_, _), do: 1

  #  Stolen from https://stackoverflow.com/a/42887944/572562
  defp transpose(rows), do: rows |> List.zip() |> Enum.map(&Tuple.to_list/1)
end
