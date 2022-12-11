defmodule TuningTrouble do
  def packet_position(input), do: input |> String.codepoints() |> find_sequence(4, 4)
  def message_position(input), do: input |> String.codepoints() |> find_sequence(14, 14)

  defp find_sequence(letters, length, position) do
    if letters |> Enum.take(length) |> Enum.uniq() |> length() == length do
      position
    else
      letters |> Enum.drop(1) |> find_sequence(length, position + 1)
    end
  end
end
