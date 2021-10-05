defmodule FlightexTest do
  use ExUnit.Case

  describe "start_agents/0" do
    test "when call, start bookings and users agents" do
      response = Flightex.start_agents()

      assert {:ok, _pid} = response
    end
  end
end
