defmodule EventCast.Queue do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def handle_cast({:enqueue, event} , events) do
    { :noreply, [event|events] }
  end

  def handle_call(:next, _client, [event|tail]) do
    future = Task.async(EventCast.Worker, :fire, [event, &(String.reverse(&1))])
    result = Task.await(future)
    IO.puts("result: #{result}")
    { :reply, result, [tail] }
  end

  def enqueue(event) do
    GenServer.cast(__MODULE__, {:enqueue, event})
  end

  def next do
    GenServer.call(__MODULE__, :next)
  end

end
