defmodule SimpleCache do
  use Application

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
