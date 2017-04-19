defmodule EventCast.Sim.Loop do

  def start_link do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def add(object) do
    Agent.update(__MODULE__, fn(objects) -> objects ++ [object] end)
  end

  def remove(object) do
    Agent.update(__MODULE__, fn(objects) -> List.delete(objects, object) end)
  end

  def next do
    Agent.get_and_update(__MODULE__, fn
      ([]) -> { nil, [] }
      ([head|tail]) -> { head, tail ++ [head] }
    end)
  end

  def size do
    Agent.get(__MODULE__, fn(objects) -> Enum.count(objects) end )
  end

end
