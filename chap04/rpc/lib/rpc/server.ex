defmodule Rpc.Server do
  @author "Paul Wilson after Erlang and OTP in action"
  @doc """
    RPC over TCP server. Defines a serer pocess that listens for incoming
    TCP connections and allows the user to execure RPC commands via that TRC stream
    """

  use GenServer

  @server __MODULE__
  @default_port 1055

  defmodule State do
    defstruct port: nil, lsock: nil, request_count: 0
  end


  ###
  # API
  def start_link(port \\ @default_port) do
    GenServer.start_link __MODULE__, port, name: @server
  end


  def get_count do
    GenServer.call @server, :get_count
  end


  def stop do
    GenServer.call @server, :stop
  end

  def init(port) do
    {:ok, lsock} = :gen_tcp.listen(port, [active: true])
    {:ok, %State{port: port, lsock: lsock}, 0}
  end


  def handle_call(:get_count, _from, state) do
    {:reply, state.request_count, state}
  end

  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end


  def handle_info({:tcp, socket, rawdata}, state) do
    do_rpc(socket, rawdata)
    request_count = state.request_count
    {:noreply, Map.put(state, :request_count, request_count + 1)}
  end


  def handle_info(:timeout, state = %State{lsock: lsock}) do
    {:ok, _sock} = :gen_tcp.accept(lsock)
    {:noreply, state}
  end


  defp do_rpc(socket, rawdata) do
    try do
      rawdata
        |> List.to_string
        |> String.strip
        |> Code.eval_string
        |> send_result_to_socket(socket)
    rescue
      e -> 
        e |> reply_on_socket(socket)
    end
  end

  defp send_result_to_socket({result, _binding}, socket) do
    result |> reply_on_socket(socket)
  end

  defp reply_on_socket(reply, socket) do
    :gen_tcp.send(socket, "#{reply |> inspect}\n")
  end

end

