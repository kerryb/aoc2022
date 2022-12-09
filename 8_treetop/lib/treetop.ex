defmodule Treetop do
  def number_visible(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&trees_in_row/1)
    |> find_visible()
    |> List.flatten()
    |> Enum.count(&elem(&1, 1))
  end

  defp trees_in_row(row) do
    row
    |> String.codepoints()
    |> Enum.map(&{String.to_integer(&1), false})
  end

  defp find_visible(trees) do
    trees
    |> Enum.map(&mark_visible_from_left/1)
    |> Enum.map(&mark_visible_from_left/1)
    |> transpose()
    |> Enum.map(&mark_visible_from_left/1)
    |> Enum.map(&mark_visible_from_left/1)
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

  #  Stolen from https://stackoverflow.com/a/42887944/572562
  defp transpose(rows), do: rows |> List.zip() |> Enum.map(&Tuple.to_list/1)
end
