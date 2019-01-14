defmodule MoneyTest do
  use ExUnit.Case
  doctest Money

  test "split even number of cents into 2 parts leaves no remainder" do
    assert Money.split(100, 2) == [50, 50]
  end

  test "split 150 cents into 3 parts leaves no remainder" do
    assert Money.split(150, 3) == [50, 50, 50]
  end

  test "split odd number of cents into 2 parts leaves remainder" do
    assert Money.split(23, 2) == [12, 11]
  end

  test "split into 4 parts leaving remainder for all but one part" do
    assert Money.split(23, 4) == [6, 6, 6, 5]
  end

  test "split into 4 parts leaving remainder for only one part" do
    assert Money.split(21, 4) == [6, 5, 5, 5]
  end
end
