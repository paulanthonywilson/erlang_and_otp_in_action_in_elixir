defmodule DiePlease do
  use GenServer

  @server __MODULE__
  @sleep_time 2 * 1000

  def start_link do
    GenServer.start_link(__MODULE__, [], name: @server)
  end

  def init([]) do
    {:ok, %{}, @sleep_time}
  end

  def handle_call(_request, _from, state) do
    reply = :ok
    {:ok, reply, state}
  end

  def handle_cast(_msg, state) do
    {:noreply, state}
  end

  def handle_info(timeout, state) do
    :i_want_to_die = :right_now # causes exception
    {:noreply, state}
  end

end
