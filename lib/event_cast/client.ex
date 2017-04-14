defmodule Client do

  def echo(payload) do
    call(:echo, payload)
  end

  def reverse(payload) do
    call(:reverse, payload)
  end

  defp call(action, payload) do
    EventCast.MessageDispatcher.process(:base, action, payload)
    receive do
      {:answer, answer} ->
        IO.puts "answer to #{action} received:"
        IO.puts inspect(answer)
    end
  end

end
