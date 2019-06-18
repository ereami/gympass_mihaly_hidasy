require_relative './pilot.rb'
require_relative './lap_data.rb'

class Race
  attr_accessor :pilots

  def initialize(max_laps=4)
    @pilots = {}
    @current_lap = nil
    @race_finished = false
    @max_laps = max_laps
  end

  def update_grid (timestamp, pilot_code, pilot_name, lap_num, lap_timing, avg_speed)
    @current_lap=lap_num
    if ! finished? && @current_lap == @max_laps
      @race_finished = true
    end

    pilot = pilots[pilot_code]
    if pilot.nil?
      pilot=Pilot.new pilot_code, pilot_name
    end

    pilot.add_lap LapData.new(lap_num, lap_timing, avg_speed), finished?

    pilots[pilot_code] = pilot

  end

  def finished?
    @race_finished
  end

  def with_ordered_grid
    ordered_grid = @pilots.sort_by { |code, pilot_data| [ -pilot_data.lap_num, pilot_data.total_time ] }
    ordered_grid.each_with_index do |grid_data, position|
      yield position+1, grid_data.last
    end     
  end
end
