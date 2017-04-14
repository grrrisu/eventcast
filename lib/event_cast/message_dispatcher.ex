defmodule EventCast.MessageDispatcher do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def handle_call({:process, %EventCast.Message{context: context} = message}, _client, clients) do
    case context do
      :base ->
        EventCast.MessageHandler.process(message)
        #  spawn(EventCast.MessageHandler, :process, [message])
        { :reply, {:ok, message} , clients }
      unknown ->
        { :reply, {:error, "unknown context #{unknown}"} , clients }
    end
  end

  def handle_cast(:register, client, clients) do
    { :noreply, [client|clients] }
  end

  def handle_cast(:unregister, client, clients) do
    { :noreply, List.delete(clients, client) }
  end

  def process(message) do
    GenServer.call(__MODULE__, {:process, message})
  end

end
