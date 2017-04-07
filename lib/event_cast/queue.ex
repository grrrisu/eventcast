defmodule EventCast.Queue do

  # def start_link do
  #   #EventCast.Queue.enqueue
  # end

  def enqueue do
    event = %Event{payload: "Hello World"}
    EventCast.Worker.fire(event, &(String.reverse(&1)))
  end

end
