defmodule NoSpaceLeft do
  def total_sizes(input) do
    input
    |> sizes()
    |> Map.values()
    |> Enum.filter(&(&1 <= 100_000))
    |> Enum.sum()
  end

  def smallest_to_delete(input) do
    sizes = sizes(input)
    extra_space_needed = sizes["/"] - 40_000_000
    sizes |> Map.values() |> Enum.filter(&(&1 >= extra_space_needed)) |> Enum.min()
  end

  defp sizes(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{path: "", sizes: %{}}, &parse_line/2)
    |> Map.get(:sizes)
  end

  defp parse_line("$ cd /", _state), do: %{path: "/", sizes: %{"/" => 0}}
  defp parse_line("$ ls", state), do: state

  defp parse_line("$ cd ..", state),
    do: Map.update!(state, :path, &parent_path/1)

  defp parse_line("$ cd " <> dir, state), do: Map.update!(state, :path, &append_path(&1, dir))

  defp parse_line("dir " <> _, state), do: state

  defp parse_line(file, state) do
    [size, _name] = String.split(file)
    add_sizes(state, state.path, String.to_integer(size))
  end

  defp parent_path(path) do
    if path =~ ~r"/.*/" do
      String.replace(path, ~r"/[^/]+$", "")
    else
      "/"
    end
  end

  defp append_path("/", name), do: "/#{name}"
  defp append_path(path, name), do: "#{path}/#{name}"

  defp add_sizes(state, "/", size), do: add_size(state, "/", size)

  defp add_sizes(state, path, size) do
    state
    |> add_size(path, size)
    |> add_sizes(parent_path(path), size)
  end

  defp add_size(state, path, size) do
    update_in(state, [:sizes, path], &((&1 || 0) + size))
  end
end
