defmodule EventCast.Worker do

  def fire(%Event{} = event) do
    event.function.(event.arguments)
  end

end
