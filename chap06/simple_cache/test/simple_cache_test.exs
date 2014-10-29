defmodule SimpleCacheTest do
  use ExUnit.Case, async: true

  ###
  # Some high level tests
  test "inserting and retrieving a key" do
    SimpleCache.insert("k1", "hello")
    SimpleCache.insert("k2", "matey")

    assert SimpleCache.lookup("k1") == {:ok, "hello"}
    assert SimpleCache.lookup("k2") == {:ok, "matey"}


  end


  test "key not found" do
    assert SimpleCache.lookup("k3") == {:error, :not_found}
  end


  test "replacing key" do
    SimpleCache.insert("k1", "hello")
    SimpleCache.insert("k1", "matey")

    assert SimpleCache.lookup("k1") == {:ok, "matey"}
  end


  test "deleting key" do
    SimpleCache.insert("k1", "hello")
    SimpleCache.delete("k1")
    assert SimpleCache.lookup("k1")  == {:error, :not_found}
  end
end
