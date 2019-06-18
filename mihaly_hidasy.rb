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
  
  pilot = {}
  f.each_line.with_index do |line, line_num|
    next if line_num == 0 || line.chomp.length == 0

    fields = line.scan /(\S+)\s*/
    timestamp, pilot_code, dash, pilot_name, lap_num, lap_timing, avg_speed = fields.flatten 
    race.update_grid(lap_num)

    lap_timing_ms = LapData.convert_lap_timing_string(lap_timing)

    pilot[pilot_code] = { :pilot_name => pilot_name, :lap_num => lap_num, :total_time => 0 } if pilot[pilot_code].nil?
    pilot[pilot_code][:lap_num] = lap_num
    pilot[pilot_code][:total_time] =  pilot[pilot_code][:total_time] + lap_timing_ms  

  end

  puts "\u{1f3c1}  Terminada a corrida!"
  final_grid = pilot.sort_by { |code, pilot_data| [ -pilot_data[:lap_num].to_i, pilot_data[:total_time] ] }
  
  puts "Pos\tCod.Piloto\tNom.Piloto\t\tNo.Voltas\tTempo Total"
  final_grid.each_with_index do |position_data, position|
    pilot_code = position_data.first
    pilot_data = position_data.last
    puts "#{position + 1} \t #{pilot_code}\t#{pilot_data[:pilot_name]}\t\t#{pilot_data[:lap_num]}\t#{pilot_data[:total_time]}"
  end
end


