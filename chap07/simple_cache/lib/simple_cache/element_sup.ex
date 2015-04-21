defmodule SimpleCache.ElementSup do
  use Supervisor

  @server __MODULE__

  ###
  # API functions
  def start_link do
    Supervisor.start_link(__MODULE__, :ok, [name: @server])
  end


  def start_child(value, lease_time) do
    Supervisor.start_child(@server, [value, lease_time])
  end

  ###
  # OTP callbacks
  def init(:ok) do
    element = {:simple_cache_element, {SimpleCache.Element, :start_link, []}, :temporary, :brutal_kill, :worker, [SimpleCache.Element]}
    children = [element]
    restart_strategy = {:simple_one_for_one, 0, 1}
    {:ok, {restart_strategy, children}}

  end
end
