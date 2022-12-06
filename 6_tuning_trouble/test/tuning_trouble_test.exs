defmodule TuningTroubleTest do
  use ExUnit.Case

  describe "TuningTrouble.packet_position/1" do
    test "returns the number of characters before four consecutive different cahracters are received" do
      assert TuningTrouble.packet_position("""
             mjqjpqmgbljsphdztnvjfqwrcgsmlb
             """) == 7
    end
  end

  describe "TuningTrouble.message_position/1" do
    test "returns the number of characters before 14 consecutive different cahracters are received" do
      assert TuningTrouble.message_position("""
             mjqjpqmgbljsphdztnvjfqwrcgsmlb
             """) == 19
    end
  end
end
