class LapData

  def self.convert_lap_timing_string(lap_timing)
    lap_timing_parts = lap_timing.scan( /(\d+):(\d+).(\d+)/ )
    min, s, ms = lap_timing_parts.flatten.map { |t| t.to_i }
    return (min * 60 + s) * 1000 + ms
  end

end
