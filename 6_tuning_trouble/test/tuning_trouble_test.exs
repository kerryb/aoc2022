defmodule TuningTroubleTest do
  use ExUnit.Case

  describe "TuningTrouble.marker_position/1" do
    test "returns the number of characters before four consecutive different cahracters are received" do
      assert TuningTrouble.marker_position("""
             mjqjpqmgbljsphdztnvjfqwrcgsmlb
             """) == 7
    end
  end
end
