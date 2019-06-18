require "minitest/autorun"
require_relative "../lib/race.rb"

def sample_data
  ["23:50:17.472", "023", "M.WEBBER", 2, 64805, 42.941]
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
end
