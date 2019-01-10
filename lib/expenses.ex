defmodule Expenses do

  def split_expense(%{
    value: value,
    paid_by: payer,
    split_amounts: amounts_by_member
  }) do

    unless Enum.sum(Map.values(amounts_by_member)) == value do
      raise "amounts do not sum up to total"
    end

    amount_paid_by_member = fn
      ^payer -> value
      _member -> 0
    end

    amounts_by_member
      |> Enum.map(fn {member, due_amount} -> {member, due_amount - amount_paid_by_member.(member)} end)
      |> Enum.filter(fn {_member, amount_to_pay} -> amount_to_pay > 0 end)
      |> Enum.map(fn {member, amount_to_pay} -> %{
        value: amount_to_pay,
        owes: member,
        owes_to: payer
      } end)
      |> MapSet.new()
  end

  def split_expense(%{
    value: value,
    paid_by: payer,
    split_equally: members
  }) do

    split_value = round(value / length(members))

    split_amounts = members
      |> Enum.map(fn member -> {member, split_value} end)
      |> Map.new()

    split_expense(%{value: value, paid_by: payer, split_amounts: split_amounts})
  end
end
