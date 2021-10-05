defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(from_date, to_date) do
    from_date
    |> BookingAgent.get_between_period(to_date)
    |> generate_report()
  end

  defp generate_report(bookings) do
    booking_list = build_booking_list(bookings)

    File.write("report.csv", booking_list)
  end

  defp build_booking_list(bookings) do
    bookings
    |> Enum.map(&booking_string/1)
  end

  defp booking_string(%Booking{
         user_id: user_id,
         local_origin: local_origin,
         local_destination: local_destination,
         complete_date: complete_date
       }) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end
end
