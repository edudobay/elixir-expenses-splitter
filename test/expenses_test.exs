defmodule ExpensesTest do
  use ExUnit.Case
  doctest Expenses

  test "split an expense equally between two people, when one of them has paid for the whole bill" do
    assert Expenses.split_expense(%{
      value: 42,
      paid_by: :alice,
      split_equally: [:alice, :bob]
    }) == MapSet.new([
      %{ value: 21, owes: :bob, owes_to: :alice },
    ])
  end

  test "split an expense equally between two people, when a third person has paid for the whole bill" do
    assert Expenses.split_expense(%{
      value: 42,
      paid_by: :carol,
      split_equally: [:alice, :bob]
    }) == MapSet.new([
      %{ value: 21, owes: :alice, owes_to: :carol },
      %{ value: 21, owes: :bob, owes_to: :carol },
    ])
  end

  test "split an expense giving exact shares" do
    assert Expenses.split_expense(%{
      value: 42,
      paid_by: :carol,
      split_amounts: %{
        alice: 32,
        bob: 10,
      }
    }) == MapSet.new([
      %{ value: 32, owes: :alice, owes_to: :carol },
      %{ value: 10, owes: :bob, owes_to: :carol },
    ])
  end
end
