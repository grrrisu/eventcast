defmodule EventCast.Sim.Time do

  def start_link(units_since_start \\ 0.0, time_unit \\ 1) do
    Agent.start_link(fn -> { units_since_start, time_unit, nil } end, name: __MODULE__)
  end

  def set_start_time do
    Agent.update(__MODULE__, fn({ units_since_start, time_unit, _ }) ->
      { units_since_start, time_unit, now() }
    end)
  end

  def elapsed do
    Agent.get(__MODULE__, fn
      { units_since_start, _time_unit, nil } ->
        units_since_start
      { units_since_start, time_unit, started } ->
        units_since_start + (now() - started) / time_unit
    end)
  end

  defp now do
    DateTime.utc_now |> DateTime.to_unix
  end

end
