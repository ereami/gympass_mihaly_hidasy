require "minitest/autorun"
require_relative "../lib/race.rb"

def sample_data
  ["23:50:17.472", "023", "M.WEBBER", 2, 64805, 42.941]
end

def sample_massa_laps
  [ ["23:49:08.277", "038", "F.MASSA", 1, 62852, 44.275],
    ["23:50:11.447", "038", "F.MASSA", 2, 63170, 44.053],
    ["23:51:14.216", "038", "F.MASSA", 3, 62769, 44.334] ]
end

describe Race do
  MAX = 4
  before do
    @race = Race.new(MAX)
  end

  describe "when grid updated with one valid data register from file" do
    timestamp, pilot_code, pilot_name, lap_num, lap_timing, avg_speed = sample_data.flatten

    it "should have the pilot in the pilots list" do
      @race.update_grid timestamp, pilot_code, pilot_name, lap_num, lap_timing, avg_speed
      assert_equal pilot_name, @race.pilots[pilot_code].name
    end

    it "should have the lap_timing correctly associated to pilot's first lap" do
      @race.update_grid timestamp, pilot_code, pilot_name, lap_num, lap_timing, avg_speed
      assert_equal lap_timing, @race.pilots[pilot_code].laps.first.time_in_ms
    end
  end

  describe "when number of laps is less than #{MAX}" do
    timestamp, pilot_code, pilot_name, lap_num, lap_timing, avg_speed = sample_data.flatten
    it "race is not finished yet`" do
      @race.update_grid timestamp, pilot_code, pilot_name, lap_num, lap_timing, avg_speed
      assert_equal false, @race.finished?
    end
  end

  describe "when all laps computed, and Massa has the best lap" do
    it "should be Massa's lap the race's best lap" do
      sample_massa_laps.each do |lap|
        timestamp, pilot_code, pilot_name, lap_num, lap_timing, avg_speed = lap.flatten
        @race.update_grid timestamp, pilot_code, pilot_name, lap_num, lap_timing, avg_speed
      end 

      best_lap_data = @race.best_lap

      assert_equal ["F.MASSA", 62769], [best_lap_data[:pilot].name, best_lap_data[:lap].time_in_ms]
    end
  end
end
