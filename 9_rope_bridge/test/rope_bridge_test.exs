defmodule RopeBridgeTest do
  use ExUnit.Case

  describe "RopeBridge.count_visited/1" do
    test "calculates how many positions the rope’s tail visited" do
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
  end
end
