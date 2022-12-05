defmodule SupplyStacksTest do
  use ExUnit.Case

  describe "SupplyStacks.final_tops_one_by_one/1" do
    test "returns the crates that end up at the top of each pile" do
      assert SupplyStacks.final_tops_one_by_one("""
                 [D]    
             [N] [C]    
             [Z] [M] [P]
              1   2   3 

             move 1 from 2 to 1
             move 3 from 1 to 3
             move 2 from 2 to 1
             move 1 from 1 to 2
             """) == "CMZ"
    end
  end

  describe "SupplyStacks.final_tops_all_together()/1" do
    test "returns the crates that end up at the top of each pile" do
      assert SupplyStacks.final_tops_all_together("""
                 [D]    
             [N] [C]    
             [Z] [M] [P]
              1   2   3 

             move 1 from 2 to 1
             move 3 from 1 to 3
             move 2 from 2 to 1
             move 1 from 1 to 2
             """) == "MCD"
    end
  end

  describe "SupplyStacks.initial_stacks/1" do
    test "builds a map of positions to stacks, which are lists starting with the topmost item" do
      assert SupplyStacks.initial_stacks("""
                 [D]    
             [N] [C]    
             [Z] [M] [P]
              1   2   3 

             move 1 from 2 to 1
             move 3 from 1 to 3
             move 2 from 2 to 1
             move 1 from 1 to 2
             """) == %{1 => ~w[N Z], 2 => ~w[D C M], 3 => ~w[P]}
    end
  end
end
