require "minitest/autorun"
require_relative "../lib/lap_data.rb"

describe LapData do
  describe "when Lap Timing is a string of format 1:30.100" do
    lap_timing = "1:30.100"
    it "should be converted to 90100 milliseconds" do
      assert_equal 90100, LapData.convert_lap_timing_string(lap_timing)
    end
  end
end
