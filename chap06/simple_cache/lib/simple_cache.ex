defmodule SimpleCache do
  use Application


  ##
  # API
  def insert(key, value) do
    case SimpleCache.Store.lookup(key) do
      {:ok, pid} -> SimpleCache.Element.replace(pid, value)
      {:error, _} ->
        {:ok, pid} = SimpleCache.Element.create(value)
        SimpleCache.Store.insert(key, pid)
    end
  end


  def lookup(key) do
    # I'm a bit uncomfortable with this error handling strategy
    try do
      {:ok, pid} = SimpleCache.Store.lookup(key)
      {:ok, value} = SimpleCache.Element.fetch(pid)
      {:ok, value}
    # catch
    #   # Ok, seem to need to catch exit in the case of a delete immediately followed by a lookup:
    #   # timing is such that the pid is returned from the store, but the element process terminates
    #   # before the OTP fetch call is processed
    #   :exit, _ ->  {:error, :not_found}
    rescue
      _ ->
      {:error, :not_found}
    end
  end


  def delete(key) do
    case SimpleCache.Store.lookup(key) do
      {:ok, pid} -> SimpleCache.Element.delete pid
      {:error, _reason} -> :ok
    end
  end

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    SimpleCache.Store.init
    case SimpleCache.Sup.start_link do
      success = {:ok, _pid} -> success
      failure -> {:error, failure}
    end
  end

end
