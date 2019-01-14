defmodule Money do

  import Integer, only: [mod: 2, floor_div: 2]

  def split(cents, parts) do
    quotient = floor_div(cents, parts)
    remainder = mod(cents, parts)

    repeat(quotient + 1, remainder) ++ repeat(quotient, parts - remainder)
  end

  defp repeat(value, times) do
    if times > 0 do
      Enum.reduce(1..times, [], fn _i, acc -> [value | acc] end)
    else
      []
    end
  end

end
