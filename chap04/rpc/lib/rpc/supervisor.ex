defmodule Rpc.Supervisor do
  use Supervisor


  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    server = {:rpc_server, {Rpc.Server, :start_link, []}, :permanent, 2000, :worker, [Rpc.Server]}
    children = [server]
    restart_strategy = {:one_for_one, 10, 60}
    {:ok, {restart_strategy, children}}

  end
end
