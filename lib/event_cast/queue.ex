defmodule EventCast.Queue do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def handle_cast({:enqueue, event} , events) do
    { :noreply, events ++ [event] }
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

  def enqueue(nil) do
    # ignore
  end

  def enqueue(event) do
    GenServer.cast(__MODULE__, {:enqueue, event})
    next()
  end

  def next do
    GenServer.cast(__MODULE__, :next)
  end

  defp fire_event(event) do
    Task.async(EventCast.EventProcess, :fire, [event])
    |> Task.await
    |> EventCast.Broadcaster.broadcast_to_all
  end

end
