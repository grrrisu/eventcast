defmodule Client do

  def echo(payload) do
    call(:echo, payload)
  end

  def reverse(payload) do
    call(:reverse, payload)
  end

  def crash() do
    call(:crash, nil)
  end

  defp call(action, payload) do
    EventCast.MessageDispatcher.process(:base, action, payload)
    listen()
  end

  defp listen do
    receive do
      {:answer, answer} ->
        IO.puts "answer: #{inspect(answer)}"
        #listen()
    end
  end

end
