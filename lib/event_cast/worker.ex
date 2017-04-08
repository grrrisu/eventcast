defmodule EventCast.Worker do

  def fire(event) do
    event.function.(event.arguments)
  end

end
