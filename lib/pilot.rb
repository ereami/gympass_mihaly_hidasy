require_relative './lap_data.rb' 

class Pilot
  attr_accessor :code, :name, :laps

  def initialize (code, name, laps=[])
    self.code = code
    self.name = name
    self.laps = laps
  end

  def add_lap (lap_data)
    @laps << lap_data
  end

  def total_time
    @laps.inject(0) { |total_time, lap_data| total_time + lap_data.time_in_ms } 
  end

end
