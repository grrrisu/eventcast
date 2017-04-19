defmodule EventCast.Sim.Supervisor do
  use Supervisor

  def start_link do
    {:ok, pid} = Supervisor.start_link(__MODULE__, [])
    start_children(pid)
  end

  def start_children(supervisor) do
    {:ok, _pid } = Supervisor.start_child(supervisor, worker(EventCast.Sim.Time, []))
    {:ok, _pid } = Supervisor.start_child(supervisor, worker(EventCast.Sim.Loop, []))
    {:ok, _pid } = Supervisor.start_child(supervisor, worker(EventCast.Sim.Ticker, []))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end

end
