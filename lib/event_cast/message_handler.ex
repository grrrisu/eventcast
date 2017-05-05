defmodule EventCast.MessageHandler do

  def process(%EventCast.Message{action: :echo, payload: payload}) do
    queue fn -> payload end
  end

  def process(%EventCast.Message{action: :reverse, payload: payload}) do
    queue fn -> (String.reverse(payload)) end
  end

  def process(%EventCast.Message{action: :crash, payload: _payload}) do
    queue fn -> raise "CRASH!!!" end
  end

  def process(%EventCast.Message{action: unknown, payload: _}) do
    IO.puts "TODO unknown action #{unknown}, send error back to client"
  end

  defp queue(function) do
    %EventCast.Event{ function: function }
    |> EventCast.Queue.enqueue
  end

end
