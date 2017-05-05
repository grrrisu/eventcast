defmodule EventCast do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  use Application

  def start(_type, _args) do
    IO.puts "starting the event cast master supervisor"
    {:ok, _pid} = EventCast.Supervisor.start_link
  end

  def stop(state) do
    IO.puts "stopping the event cast master with state #{state}"
  end
end
