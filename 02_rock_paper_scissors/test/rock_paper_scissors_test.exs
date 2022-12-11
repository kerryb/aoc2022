defmodule RockPaperScissorsTest do
  use ExUnit.Case

  describe "RockPaperScissors.score/1" do
    test "calculates the score" do
      assert RockPaperScissors.score("""
             A Y
             B X
             C Z
             """) == 15
    end
  end

  describe "RockPaperScissors.score_properly/1" do
    test "calculates the score" do
      assert RockPaperScissors.score_properly("""
             A Y
             B X
             C Z
             """) == 12
    end
  end
end
