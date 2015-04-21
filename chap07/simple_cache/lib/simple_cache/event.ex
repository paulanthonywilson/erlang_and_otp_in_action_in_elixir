defmodule SimpleCache.Event do
  use GenEvent

  @name __MODULE__

  def start_link do
    GenEvent.start_link([name: @name])
  end

  def add_handler(handler, args) do
    GenEvent.add_handler(@name, handler, args)
  end

  def delete_handler(handler, args) do
    GenEvent.delete_handler(@name, handler, args)
  end

  def lookup(key) do
    GenEvent.notify(@name, {:lookup, key})
  end

  def create(key, value) do
    GenEvent.notify(@name, {:create, {key, value}})
  end

  def replace(key, value) do
    GenEvent.replace(@name, {:replace, {key, value}})
  end

  def delete(key) do
    GenEvent.replace(@name, {:delete, key})
  end
end
