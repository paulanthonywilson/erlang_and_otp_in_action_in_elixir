defmodule Rpc.Supervisor do
  use Supervisor


  def start_link do
    res = Supervisor.start_link(__MODULE__, [])
    IO.puts res |> inspect
    res
  end

  def init([]) do
    IO.puts "innit"
    server = {:rpc_server, {Rpc.Server, :start_link, []}, :permanent, 2000, :worker, [Rpc.Server]}
    children = [server]
    restart_strategy = {:one_for_one, 0, 1}
    {:ok, {restart_strategy, children}}

  end
end
