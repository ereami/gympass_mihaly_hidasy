class LapData
  attr_accessor :number, :time_in_ms, :average_speed

  def initialize (number = 0, time_in_ms = 0, average_speed = 0)
    @number = number
    @time_in_ms = time_in_ms
    @average_speed = average_speed 
  end

  def self.convert_lap_timing_string(lap_timing)
    lap_timing_parts = lap_timing.scan( /(\d+):(\d+).(\d+)/ )
    min, s, ms = lap_timing_parts.flatten.map { |t| t.to_i }
    return (min * 60 + s) * 1000 + ms
  end

  def self.convert_lap_timing_to_string(lap_timing)
    min_s, ms = lap_timing.divmod 1000
    min, s = min_s.divmod 60
    "%d:%02d.%03d" % [min, s, ms]
  end

  def self.convert_avg_speed_string(avg_speed)
    if avg_speed =~ /,/
      avg_speed = avg_speed.gsub((/,/), ".")
    end
    avg_speed.to_f
  end


end
