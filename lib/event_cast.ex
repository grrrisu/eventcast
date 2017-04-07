defmodule EventCast do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  use Application

  def start(_type, _args) do
    {:ok, _pid} = EventCast.Supervisor.start_link
  end
end
