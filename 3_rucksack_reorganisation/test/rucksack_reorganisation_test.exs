defmodule RucksackReorganisationTest do
  use ExUnit.Case

  describe "RucksackReorganisation.priority/1" do
    test "returns the letter number for a–z" do
      assert RucksackReorganisation.priority(?a) == 1
      assert RucksackReorganisation.priority(?z) == 26
    end

    test "returns the letter number + 26 for A–Z" do
      assert RucksackReorganisation.priority(?A) == 27
      assert RucksackReorganisation.priority(?Z) == 52
    end
  end

  describe "RucksackReorganisation.split_chars/1" do
    test "returns two sets of chars containing the first and second half of the letters" do
      assert RucksackReorganisation.split_chars("Foobar") ==
               {MapSet.new([?F, ?o]), MapSet.new([?b, ?a, ?r])}
    end
  end

  describe "RucksackReorganisation.sum_of_priorities/1" do
    test "returns the sum of priorities of common letters" do
      assert RucksackReorganisation.sum_of_priorities("""
             vJrwpWtwJgWrhcsFMMfFFhFp
             jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
             PmmdzqPrVvPwwTWBwg
             wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
             ttgJtRGJQctTZtZT
             CrZsJsPPZsGzwwsLwLmpwMDw
             """) == 157
    end
  end

  describe "RucksackReorganisation.sum_of_badges/1" do
    test "returns the sum of priorities of common letters in each set of three lines" do
      assert RucksackReorganisation.sum_of_badges("""
             vJrwpWtwJgWrhcsFMMfFFhFp
             jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
             PmmdzqPrVvPwwTWBwg
             wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
             ttgJtRGJQctTZtZT
             CrZsJsPPZsGzwwsLwLmpwMDw
             """) == 70
    end
  end
end
