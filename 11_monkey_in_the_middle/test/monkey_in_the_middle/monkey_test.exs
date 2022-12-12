defmodule MonkeyInTheMiddle.MonkeyTest do
  use ExUnit.Case

  alias MonkeyInTheMiddle.Monkey

  describe "MonkeyInTheMiddle.Monkey.parse/1" do
    test "extracts each monkey" do
      assert %{0 => %{id: 0}, 1 => %{id: 1}} =
               Monkey.parse("""
               Monkey 0:
                 ...
               Monkey 1:
                 ...
               """)
    end

    test "extracts the starting items" do
      assert %{0 => %{items: [79, 98]}} =
               Monkey.parse("""
               Monkey 0:
                 Starting items: 79, 98
               """)
    end

    test "builds a function for an addition operation " do
      %{0 => %{operation: operation}} =
        Monkey.parse("""
        Monkey 0:
          Operation: new = old + 42
        """)

      assert operation.(2) == 44
    end

    test "builds a function for a multiplication operation " do
      %{0 => %{operation: operation}} =
        Monkey.parse("""
        Monkey 0:
          Operation: new = old * 2
        """)

      assert operation.(3) == 6
    end

    test "builds a function for a square operation " do
      %{0 => %{operation: operation}} =
        Monkey.parse("""
        Monkey 0:
          Operation: new = old * old
        """)

      assert operation.(3) == 9
    end

    test "extracts the test divisor" do
      assert %{0 => %{divisor: 7}} =
               Monkey.parse("""
               Monkey 0:
                 Test: divisible by 7
               """)
    end

    test "extracts the monkey index to throw to if true" do
      assert %{0 => %{if_true: 3}} =
               Monkey.parse("""
               Monkey 0:
                   If true: throw to monkey 3
               """)
    end

    test "extracts the monkey index to throw to if false" do
      assert %{0 => %{if_false: 4}} =
               Monkey.parse("""
               Monkey 0:
                   If false: throw to monkey 4
               """)
    end

    test "initialises inspect_count to zero" do
      assert %{0 => %{inspect_count: 0}} =
               Monkey.parse("""
               Monkey 0:
                   ...
               """)
    end
  end

  describe "MonkeyInTheMiddle.Monkey.throw/1" do
    test "returns the monkey without the thrown item and with an incremented inspection count, the index to throw to and the worry level to throw" do
      monkey = %Monkey{
        items: [79, 98],
        operation: &(&1 * 19),
        divisor: 23,
        if_true: 2,
        if_false: 3,
        inspect_count: 0
      }

      assert Monkey.throw(monkey, &div(&1, 3)) ==
               {%{monkey | items: [98], inspect_count: 1}, 500, 3}
    end

    test "returns :no_items when everything’s been thrown" do
      assert Monkey.throw(%Monkey{items: []}, & &1) == :no_items
    end
  end
end
