defmodule RockPaperScissorsTest do
  use ExUnit.Case

  test "calculates the score" do
    assert RockPaperScissors.score("""
           A Y
           B X
           C Z
           """) == 15
  end
end
