defmodule ReverseList do

  def reverse [a, b | t] do
    reverse(t) ++ [b, a]
  end

  def reverse(list) do
    list
  end


  def tailrev(list) do
    tailrev(list, [])
  end


  defp tailrev([], acc) do
    acc
  end
  

  defp tailrev([h|t], acc) do
    tailrev(t, [h|acc])
  end
end
