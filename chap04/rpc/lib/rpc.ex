defmodule Rpc do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    case Rpc.Supervisor.start_link do
      {:ok, pid} -> {:ok, pid}
      other -> {:error, other}
    end

  end
end
