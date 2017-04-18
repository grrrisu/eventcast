defmodule EventCast.Sim.Ticker do
  @interval 2000 # 2 sec

  def start_link do
    spawn(__MODULE__, :tick, [])
  end

  def tick do
    receive do
    after @interval ->
      object = EventCast.Sim.Loop.next
      event  = create_sim_event(object)
      EventCast.Queue.enqueue(event)
      tick()
    end
  end

  # def create_sim_event(nil) do
  #   # do nothing
  # end

  def create_sim_event(object) do
    %Event{payload: object, function: fn -> IO.puts("tick") end }
  end

end
