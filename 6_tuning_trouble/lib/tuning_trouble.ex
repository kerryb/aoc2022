defmodule TuningTrouble do
  def marker_position(input), do: marker_position(input, 4)

  defp marker_position(<<a>> <> <<b>> <> <<c>> <> <<d>> <> _tail, position)
       when a != b and a != c and a != d and b != c and b != d and c != d do
    position
  end

  defp marker_position(<<_>> <> tail, position), do: marker_position(tail, position + 1)
end
