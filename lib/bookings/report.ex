defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent

  def call(from_date, to_date) do
    from_date
    |> BookingAgent.get_between_period(to_date)
  end
end
