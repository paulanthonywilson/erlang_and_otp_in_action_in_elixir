defmodule ReverseListTest do
  use ExUnit.Case
  import ReverseList, only: [reverse: 1, tailrev: 1]

  test "no op reversing" do
    assert reverse([]) == []
    assert reverse([:a]) == [:a]
  end


  test "reversing" do
    assert reverse([:a, :b]) == [:b, :a]
    assert reverse([:a, :b, :c]) == [:c, :b, :a]
    assert reverse([:a, :b, :c, :d]) == [:d, :c, :b, :a]
  end


  test "tailrev no op reversing" do
    assert tailrev([]) == []
    assert tailrev([:a]) == [:a]
  end


  test "tailrev reversing" do
    assert tailrev([:a, :b]) == [:b, :a]
    assert tailrev([:a, :b, :c]) == [:c, :b, :a]
    assert tailrev([:a, :b, :c, :d]) == [:d, :c, :b, :a]
  end
end
