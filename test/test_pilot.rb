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
    lap_1 = LapData.new() ; lap_1.number = 1; lap_1.time_in_ms = 1000
    lap_2 = LapData.new() ; lap_2.number = 2; lap_2.time_in_ms = 1042
    it "should have a total time os 2042 ms" do
      @pilot.add_lap lap_1
      @pilot.add_lap lap_2

      assert_equal 2042, @pilot.total_time
    end

    it "should have lap of 1000ms as the best lap" do
      @pilot.add_lap lap_1
      @pilot.add_lap lap_2

      assert_equal lap_1, @pilot.best_lap
    end 
  end

  describe "when pilot pass final lap" do
    lap_1 = LapData.new(2, 1000, 40)
    lap_2 = LapData.new(3, 1042, 41)

    it "should be flagged as race_finished" do
      @pilot.add_lap lap_1, true
      assert_equal true, @pilot.race_finished
    end

    it "should not add more laps after race_finished is true" do
      @pilot.add_lap lap_1, true
      @pilot.add_lap lap_2
      assert_equal lap_1.number, @pilot.lap_num
    end
  end
end
