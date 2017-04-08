defmodule EventCast.Queue do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def handle_cast({:enqueue, event} , events) do
    { :noreply, [event|events] }
  end

  def handle_cast(:next, []) do
    # wait until a new event will be enqueued
    { :noreply, [] }
  end

  def handle_cast(:next, [event|tail]) do
    fire_event(event)
    next()
    { :noreply, tail }
  end

  def enqueue(event) do
    GenServer.cast(__MODULE__, {:enqueue, event})
    next()
  end

  def next do
    GenServer.cast(__MODULE__, :next)
  end

  defp fire_event(event) do
    future = Task.async(EventCast.Worker, :fire, [event, event.function])
    result = Task.await(future)
    IO.puts("result: #{result}")
  end

end
