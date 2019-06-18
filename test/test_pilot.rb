require "minitest/autorun"
require_relative "../lib/pilot.rb"
require_relative "../lib/lap_data.rb"

describe Pilot do
  before do
    @pilot = Pilot.new("1", "J.Fangio")
  end

  describe "when no laps added yet" do
    it "should have zero lap data`" do
      assert_equal 0, @pilot.laps.length
    end
  end

  describe "when first lap is computed" do
    it "then first lap of pilot should correspond to computed lap" do
      lap = LapData.new() ; lap.time_in_ms = 1042
      @pilot.add_lap lap
      assert_equal lap.time_in_ms, @pilot.laps.first.time_in_ms
    end
  end

  describe "when two laps of 1000 and 1042  ms are added" do
    it "should have a total time os 2042 ms" do
      lap_1 = LapData.new() ; lap_1.time_in_ms = 1000
      lap_2 = LapData.new() ; lap_2.time_in_ms = 1042

      @pilot.add_lap lap_1
      @pilot.add_lap lap_2

      assert_equal 2042, @pilot.total_time
    end
  end
end
