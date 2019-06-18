require_relative './lap_data.rb' 

class Pilot
  attr_accessor :code, :name, :lap_num, :laps, :race_finished

  def initialize (code, name, laps=[])
    @code = code
    @name = name
    @laps = laps
    @race_finished = false
  end

  def add_lap (lap, final_lap=false)
    return @laps if @race_finished

    @lap_num = lap.number
    @race_finished = final_lap
    @laps << lap
  end

  def total_time
    @laps.inject(0) { |total_time, lap_data| total_time + lap_data.time_in_ms } 
  end

  def best_lap
    @laps.min { |lap1, lap2| lap1.time_in_ms <=> lap2.time_in_ms }
  end 

end
