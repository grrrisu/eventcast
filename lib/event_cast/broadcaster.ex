defmodule EventCast.Broadcaster do

  def start_link do
    Agent.start_link(fn -> MapSet.new end, name: __MODULE__)
  end

  def add({pid, _ref}) do
    Agent.update(__MODULE__, fn(clients) -> MapSet.put(clients, pid) end)
  end

  def get_clients do
    Agent.get(__MODULE__, fn(clients) -> clients end)
  end

  def remove(client) do
    Agent.update(__MODULE__, fn(clients) -> MapSet.delete(clients, client) end)
  end

  def broadcast_to_all(answer) do
    spawn(__MODULE__, :broadcast_to_clients, [get_clients(), answer])
  end

  def broadcast_to_clients(clients, answer) do
    Enum.each(clients, fn(pid) ->
      send(pid, {:answer, answer})
    end)
  end

end
