defmodule MonkeyInTheMiddleTest do
  use ExUnit.Case

  describe "MonkeyInTheMiddle.parse/1" do
    test "extracts each monkey" do
      assert [%{id: 0}, %{id: 1}] =
               MonkeyInTheMiddle.parse("""
               Monkey 0:
                 ...
               Monkey 1:
                 ...
               """)
    end

    test "extracts the starting items" do
      assert [%{items: [79, 98]}] =
               MonkeyInTheMiddle.parse("""
               Monkey 0:
                 Starting items: 79, 98
               """)
    end

    test "builds a function for an addition operation " do
      [%{operation: operation}] =
        MonkeyInTheMiddle.parse("""
        Monkey 0:
          Operation: new = old + 42
        """)

      assert operation.(2) == 44
    end

    test "builds a function for a multiplication operation " do
      [%{operation: operation}] =
        MonkeyInTheMiddle.parse("""
        Monkey 0:
          Operation: new = old * 2
        """)

      assert operation.(3) == 6
    end

    test "builds a function for a square operation " do
      [%{operation: operation}] =
        MonkeyInTheMiddle.parse("""
        Monkey 0:
          Operation: new = old * old
        """)

      assert operation.(3) == 9
    end

    test "extracts the test divisor" do
      assert [%{divisor: 7}] =
               MonkeyInTheMiddle.parse("""
               Monkey 0:
                 Test: divisible by 7
               """)
    end

    test "extracts the monkey index to throw to if true" do
      assert [%{if_true: 3}] =
               MonkeyInTheMiddle.parse("""
               Monkey 0:
                   If true: throw to monkey 3
               """)
    end

    test "extracts the monkey index to throw to if false" do
      assert [%{if_false: 4}] =
               MonkeyInTheMiddle.parse("""
               Monkey 0:
                   If false: throw to monkey 4
               """)
    end
  end
end
