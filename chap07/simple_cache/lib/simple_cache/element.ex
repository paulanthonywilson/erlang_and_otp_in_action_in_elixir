defmodule SimpleCache.Element do
  use GenServer

  @server __MODULE__
  @default_lease_time 60 * 60 * 24

  defmodule State do
    defstruct value: nil, lease_time: nil, start_time: nil
  end

  ###
  # API
  def create(value, lease_time \\ @default_lease_time) do
    SimpleCache.Sup.start_child(value, lease_time)
  end

  def fetch(pid) do
    GenServer.call(pid, :fetch)
  end

  def replace(pid, value) do
    GenServer.cast(pid, {:replace, value})
  end

  def delete(pid) do
    GenServer.cast(pid, :delete)
  end


  ###
  # OTP - callback via supervisor
  def start_link(value, lease_time) do
    GenServer.start_link(__MODULE__, [value, lease_time], [])
  end

  def init([value, lease_time]) do
    start_time = now_in_gregorian_seconds
    {:ok,
      %State{value: value, lease_time: lease_time, start_time: start_time},
      time_left(start_time, lease_time)}
  end

  def handle_call(:fetch, _from, state = %State{value: value, lease_time: lease_time, start_time: start_time}) do
    {:reply, {:ok, value}, state, time_left(start_time, lease_time)}
  end

  def handle_cast({:replace, value}, state) do
    {:noreply, Map.put(state, :value, value), time_left(state.start_time, state.lease_time)}
  end

  def handle_cast(:delete, state) do
    {:stop, :normal, state}
  end

  def handle_info(:timeout, state) do
    IO.puts "timeout #{state |> inspect}"
    {:stop, :normal, state}
  end

  def terminate(_reason, _state) do
    SimpleCache.Store.delete self
    :ok
  end


  defp time_left(_start_time, :infinity) do
    :infinity
  end

  defp time_left(start_time, lease_time) do
    time_elapsed  = now_in_gregorian_seconds - start_time
    case lease_time - time_elapsed do
      time when time <= 0 -> 0
      time -> time * 1000
    end
  end


  defp now_in_gregorian_seconds do
    :calendar.local_time |> :calendar.datetime_to_gregorian_seconds
  end

end
