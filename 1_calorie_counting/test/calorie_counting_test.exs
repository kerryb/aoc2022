defmodule CalorieCountingTest do
  use ExUnit.Case

  test "returns the total for the elf with the most calories" do
    input = """
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
    """

    assert CalorieCounting.highest_total(input) == 24_000
  end
end
