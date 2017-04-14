defmodule EventCast.MessageDispatcher do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def handle_call({:process, %EventCast.Message{context: context} = message}, client, clients) do
    register(client)
    case context do
      :base ->
        spawn(EventCast.MessageHandler, :process, [message])
        { :reply, {:ok, message} , clients }
      unknown ->
        { :reply, {:error, "unknown context #{unknown}"} , clients }
    end
  end

  def register(client) do
    EventCast.Broadcaster.add(client)
  end

  def unregister(client) do
    EventCast.Broadcaster.remove(client)
  end

  def process(%EventCast.Message{} = message) do
    GenServer.call(__MODULE__, {:process, message})
  end

  def process(context \\ :base, action \\ :echo, payload \\ nil) do
    process(%EventCast.Message{context: context, action: action, payload: payload})
  end

end
