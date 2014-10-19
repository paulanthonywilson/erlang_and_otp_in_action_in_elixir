defmodule ReverseList do

  def reverse [a, b | t] do
    reverse(t) ++ [b, a]
  end

  def reverse(list) do
    list
  end
end
