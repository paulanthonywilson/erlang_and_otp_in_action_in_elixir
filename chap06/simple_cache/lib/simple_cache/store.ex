defmodule SimpleCache.Store do
  @tableid __MODULE__

  def init do
    :ets.new(@tableid, [:public, :named_table])
    :ok
  end


  def insert(key, pid) do
    :ets.insert(@tableid, {key, pid})
  end

  def lookup(key) do
    case :ets.lookup(@tableid, key) do
      [{^key, pid}] -> {:ok, pid}
      [] -> {:error, :not_found}
    end
  end

  def delete(pid) do
    :ets.match_delete(@tableid, {:_, pid})
  end

end
