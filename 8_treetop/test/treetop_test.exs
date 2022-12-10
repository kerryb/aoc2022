defmodule TreetopTest do
  use ExUnit.Case

  describe "Treetop.number_visible/1" do
    test "counts trees that are visible from any direction" do
      assert Treetop.number_visible("""
             30373
             25512
             65332
             33549
             35390
             """) == 21
    end
  end

  describe "Treetop.max_scenic_score/1" do
    test "returns the highest product of visible distances in each direction" do
      assert Treetop.max_scenic_score("""
             30373
             25512
             65332
             33549
             35390
             """) == 8
    end
  end
end
