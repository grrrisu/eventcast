defmodule EventCast.Sim.Ticker do
  @interval 2000 # 2 sec

  def start_link do
    pid = spawn(__MODULE__, :tick, [])
    {:ok, pid}
  end

  def tick do
    receive do
    after @interval ->
      enqueue_next_object()
      tick()
    end
  end

  def enqueue_next_object do
    EventCast.Sim.Loop.next
    |> enqueue_sim_event
  end

  def enqueue_sim_event(nil) do
    # do nothing
  end

  def enqueue_sim_event(object) do
    %EventCast.Event{function: fn -> IO.puts("tick #{inspect object}") end }
    |> EventCast.Queue.enqueue
  end

end
