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

  test "split an odd number of cents between two people: extra cents belong to share of first person mentioned" do
    assert Expenses.split_expense(%{
      value: 43,
      paid_by: :alice,
      split_equally: [:alice, :bob]
    }) == MapSet.new([
      %{ value: 21, owes: :bob, owes_to: :alice },
    ])
  end

  test "split an odd number of cents between five people: extra cents belong to the shares of earlier mentioned people" do
    assert Expenses.split_expense(%{
      value: 43,
      paid_by: :alice,
      split_equally: [:alice, :bob, :charlotte, :daniel, :evelyn]
    }) == MapSet.new([
      %{ value: 9, owes: :bob, owes_to: :alice },
      %{ value: 9, owes: :charlotte, owes_to: :alice },
      %{ value: 8, owes: :daniel, owes_to: :alice },
      %{ value: 8, owes: :evelyn, owes_to: :alice },
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
