defmodule EventCast.MessageHandler do

  def process(%EventCast.Message{context: :echo, payload: payload}) do
    queue payload, &(&1)
  end

  def process(%EventCast.Message{context: :reverse, payload: payload}) do
    queue payload, &(String.reverse(&1))
  end

  defp queue(payload, function) do
    %Event{ payload: payload, function: function }
    |> EventCast.Queue.enqueue
  end

end
