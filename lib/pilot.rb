require_relative './lap_data.rb' 

class Pilot
  attr_accessor :code, :name, :lap_num, :laps

  def initialize (code, name, laps=[])
    @code = code
    @name = name
    @laps = laps
  end

  def add_lap (lap)
    @lap_num = lap.number
    @laps << lap
  end

  def total_time
    @laps.inject(0) { |total_time, lap_data| total_time + lap_data.time_in_ms } 
  end

end
