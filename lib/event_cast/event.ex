defmodule EventCast.Event do
  defstruct function: nil
end

defprotocol EventCast.EventProcess do
  @doc "function called by worker when firing the event"
  def fire(event)
end

defimpl EventCast.EventProcess, for: EventCast.Event do
  def fire(event) do
    event.function.()
  end
end
