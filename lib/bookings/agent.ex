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

  def get_between_period(from_date, to_date),
    do:
      Agent.get(
        __MODULE__,
        &Enum.map(&1, fn {_uuid, booking} ->
          get_booking_between_period(booking, from_date, to_date)
        end)
      )

  defp get_booking_between_period(
         %Booking{complete_date: complete_date} = booking,
         from_date,
         to_date
       ) do
    booking_date = complete_date |> to_date()

    booking_date
    |> booking_date_in_period?(from_date, to_date, booking)
  end

  defp booking_date_in_period?(booking_date, from_date, to_date, booking) do
    period = Date.range(from_date, to_date)

    case booking_date in period do
      true -> {:ok, booking}
      false -> {:error, "Date not in period"}
    end
  end

  defp to_date(naive_datetime), do: NaiveDateTime.to_date(naive_datetime)

  defp get_booking(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end
end
