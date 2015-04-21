defmodule SimpleCache.EventLogger do
  use GenEvent

  def add_handler do
    SimpleCache.Event.add_handler(__MODULE__, [])
  end

  def delete_handler do
    SimpleCache.Event.delete_handler(__MODULE__, [])
  end

  # Being lazy
  def handle_event({event, args}, state) do
    Logger.log(:info, "#{event} with '#{args |> inspect}'\n")
    {:ok, state}
  end
end
