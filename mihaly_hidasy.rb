require_relative 'lib/race.rb'
require_relative 'lib/lap_data.rb'

if ARGV.length < 1
  puts "Uso: ruby mihaly_hidasy.rb <nome_arquivo.log>"
  exit
end

unless File.exists?(ARGV.first)
  STDERR.puts "Arquivo de entrada não existe." 
  exit 1 
end

File.open(ARGV.first, "r") do |f|
  race = Race.new
  
  f.each_line.with_index do |line, line_num|
    next if line_num == 0 || line.chomp.length == 0 || line =~ /Hora/

    fields = line.scan /(\S+)\s*/
    timestamp, pilot_code, dash, pilot_name, lap_num, lap_timing, avg_speed = fields.flatten 

    lap_num = lap_num.to_i
    lap_timing = LapData.convert_lap_timing_string(lap_timing)
    avg_speed = LapData.convert_avg_speed_string(avg_speed)

    race.update_grid timestamp, pilot_code, pilot_name, lap_num, lap_timing, avg_speed
  end

  puts "\u{1f3c1} \u{1f3c1} \u{1f3c1}  Terminada a corrida!  \u{1f3c1} \u{1f3c1} \u{1f3c1}" 
  puts "%3s %10s %-20s %9s %10s %15s %s" % ["Pos", "Cod.Piloto", "Nom.Piloto", "No.Voltas", "Tempo Total", "Melhor Tempo", "Melhor Volta"]

  race.with_ordered_grid do |position, pilot|
    best_lap = pilot.best_lap
    puts "%3d %10s %-20s %9d %10s %15s (#%d)" % [position, pilot.code, pilot.name, pilot.lap_num, LapData.convert_lap_timing_to_string(pilot.total_time), LapData.convert_lap_timing_to_string(best_lap.time_in_ms), best_lap.number]
  end

  best_lap_data = race.best_lap
  best_race_lap = best_lap_data[:lap]
  
  puts "\nMelhor volta da corrida \u{1f451}"
  puts "%-20s %15s (#%d)" % [ best_lap_data[:pilot].name, LapData.convert_lap_timing_to_string(best_race_lap.time_in_ms), best_race_lap.number ]

end


