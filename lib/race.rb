class Race
  def initialize(max_laps=4)
    @grid = {}
    @current_lap = nil
    @max_laps = max_laps
  end

  def update_grid (lap_data)
    @current_lap=lap_data.to_i
  end

  def finished?
    @current_lap == @max_laps
  end
end
