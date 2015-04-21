defmodule SimpleCache.Sup do
  use Supervisor

  @server __MODULE__

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, [name: @server])
  end

  def init(:ok) do
    element_sup =   {:simple_cache_slement_sup, {SimpleCache.ElementSup, :start_link, []}, :permanent, 2000, :supervisor, [SimpleCache.ElementSup]}
    event_manager = {:simple_cache_event,       {SimpleCache.Event,      :start_link, []}, :permanent, 2000, :worker,     [SimpleCache.Event]}
    children = [element_sup, event_manager]
    restart_strategy = {:one_for_one, 4, 3600}
    {:ok, {restart_strategy, children}}
  end
end
