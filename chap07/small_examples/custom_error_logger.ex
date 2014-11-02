defmodule CustomErrorLogger do
  use GenEvent

  def register_with_logger do
    Logger.add_backend(__MODULE__)
  end

  def init(args) do
    IO.puts args |> inspect
    {:ok, %{}}
  end

  def handle_event({level, _gleader, {Logger, msg, timestamp, metadata}}, state) do
    IO.puts "#{level} - #{msg}"
    {:ok, state}
  end

  
end
