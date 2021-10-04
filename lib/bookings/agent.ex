defmodule Flightex.Bookings.Agent do
  use Agent
  alias Flightex.Bookings.Booking

  def start_link(initial_state \\ %{}) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def save(%Booking{} = booking) do
    uuid = UUID.uuid4()

    Agent.update(__MODULE__, fn state -> Map.put(state, uuid, booking) end)

    {:ok, uuid}
  end

  def get(uuid), do: Agent.get(__MODULE__, &get_booking(&1, uuid))

  defp get_booking(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end
end
