defmodule CampCleanupTest do
  use ExUnit.Case

  describe "CampCleanup.count_fully_covered/1" do
    test "counts the rows where one range fully covers the other" do
      assert CampCleanup.count_fully_covered("""
             2-4,6-8
             2-3,4-5
             5-7,7-9
             2-8,3-7
             6-6,4-6
             2-6,4-8
             """) == 2
    end
  end
end
