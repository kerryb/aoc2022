defmodule RopeBridgeTest do
  use ExUnit.Case

  describe "RopeBridge.count_visited/2" do
    test "calculates how many positions a rope of length 1’s tail visited" do
      assert RopeBridge.count_visited("""
             R 4
             U 4
             L 3
             D 1
             R 4
             D 1
             L 5
             R 2
             """) == 13
    end

    test "calculates how many positions a rope of length 9’s tail visited (simple example)" do
      assert RopeBridge.count_visited(
               """
               R 4
               U 4
               L 3
               D 1
               R 4
               D 1
               L 5
               R 2
               """,
               9
             ) == 1
    end

    test "calculates how many positions a rope of length 9’s tail visited" do
      assert RopeBridge.count_visited(
               """
               R 5
               U 8
               L 8
               D 3
               R 17
               D 10
               L 25
               U 20
               """,
               9
             ) == 36
    end
  end
end
