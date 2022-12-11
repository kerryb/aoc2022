defmodule NoSpaceLeftTest do
  use ExUnit.Case

  describe "NoSpaceLeft.total_sizes/1" do
    test "returns the sum of total sizes up to 100,000" do
      assert NoSpaceLeft.total_sizes(input()) == 95437
    end
  end

  describe "NoSpaceLeft.smallest_to_delete/1" do
    test "returns the smallest size which will bring the total down to 40,000,000 or less" do
      assert NoSpaceLeft.smallest_to_delete(input()) == 24_933_642
    end
  end

  defp input do
    """
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
    """
  end
end
