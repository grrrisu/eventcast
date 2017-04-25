defmodule EventCast.Supervisor do
  use Supervisor

  def start_link do
    {:ok, pid} = Supervisor.start_link(__MODULE__, [])
    start_queue(pid)
  end

  def start_queue(supervisor) do
    {:ok, _pid } = Supervisor.start_child(supervisor, worker(EventCast.MessageSupervisor, []))
    {:ok, _pid } = Supervisor.start_child(supervisor, worker(EventCast.Sim.Supervisor, []))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end

end
