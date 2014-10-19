defmodule ReverseListTest do
  use ExUnit.Case
  import ReverseList, only: [reverse: 1]

  test "no op reversing" do
    assert reverse([]) == []
    assert reverse([:a]) == [:a]
  end


  test "reversing" do
    assert reverse([:a, :b]) == [:b, :a]
    assert reverse([:a, :b, :c]) == [:c, :b, :a]
    assert reverse([:a, :b, :c, :d]) == [:d, :c, :b, :a]
  end
end
