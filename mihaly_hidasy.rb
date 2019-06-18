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

  puts "\u{1f3c1}  Terminada a corrida!"
  puts "%3s %10s %-20s %9s %10s" % ["Pos", "Cod.Piloto", "Nom.Piloto", "No.Voltas", "Tempo Total"]

  race.with_ordered_grid do |position, pilot|
    puts "%3d %10s %-20s %9d %10s" % [position, pilot.code, pilot.name, pilot.lap_num, LapData.convert_lap_timing_to_string(pilot.total_time)]
  end

end


