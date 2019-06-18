require_relative './pilot.rb'
require_relative './lap_data.rb'

class Race
  attr_accessor :pilots

  def initialize(max_laps=4)
    @pilots = {}
    @current_lap = nil
    @max_laps = max_laps
  end

  def update_grid (timestamp, pilot_code, pilot_name, lap_num, lap_timing, avg_speed)
    pilot = pilots[pilot_code]

    if pilot.nil?
      pilot=Pilot.new pilot_code, pilot_name
    end

    pilot.add_lap LapData.new(lap_num, lap_timing, avg_speed)

    pilots[pilot_code] = pilot

    @current_lap=lap_num
  end

  def finished?
    @current_lap == @max_laps
  end
end
