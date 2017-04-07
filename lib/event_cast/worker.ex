defmodule EventCast.Worker do

  def fire(event) do
    event.payload
  end

  def fire(event, func) do
    func.(event.payload)
  end

end
