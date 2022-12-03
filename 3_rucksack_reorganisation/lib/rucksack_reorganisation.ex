defmodule RucksackReorganisation do
  def priority(letter) when letter in ?a..?z, do: letter - ?a + 1
  def priority(letter) when letter in ?A..?Z, do: letter - ?A + 27

  def split_chars(string) do
    string
    |> String.to_charlist()
    |> Enum.split(div(String.length(string), 2))
    |> then(fn {a, b} -> {MapSet.new(a), MapSet.new(b)} end)
  end

  def sum_of_priorities(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&split_chars/1)
    |> Enum.map(fn {a, b} ->
      a |> MapSet.intersection(b) |> MapSet.to_list() |> Enum.at(0) |> priority()
    end)
    |> Enum.sum()
  end
end
