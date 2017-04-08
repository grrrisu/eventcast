defmodule EventCast.MessageHandler do

  def process(%EventCast.Message{context: :echo, payload: payload}) do
    queue payload, &(&1)
  end

  def process(%EventCast.Message{context: :reverse, payload: payload}) do
    queue payload, &(String.reverse(&1))
  end

  def queue(payload, function) do
    create_event(payload, function)
    |> EventCast.Queue.enqueue
  end

  def create_event(payload, function) do
    %Event{ arguments: payload, function: function }
  end

end
