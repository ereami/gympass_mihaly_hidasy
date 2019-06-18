require "minitest/autorun"
require_relative "../lib/lap_data.rb"

describe LapData do
  describe "when Lap Timing is a string of format 1:30.100" do
    lap_timing = "1:30.100"
    it "should be converted to 90100 milliseconds" do
      assert_equal 90100, LapData.convert_lap_timing_string(lap_timing)
    end
  end

  describe "when Avg Speed is a string of format 46,590" do
    it "46,590 should be converted to the float 46.59" do
      avg_speed = "46,590"
      assert_equal 46.59, LapData.convert_avg_speed_string(avg_speed)
    end

    it "46 should be converted to the float 46" do
      avg_speed = "46"
      assert_equal 46, LapData.convert_avg_speed_string(avg_speed)
    end
    
  end
end
