require_relative 'lib/race.rb'
require_relative 'lib/lap_data.rb'

if ARGV.length < 1
  puts "Uso: ruby mihaly_hidasy.rb <nome_arquivo.log>"
  exit
end

File.open(ARGV.first, "r") do |f|
  race = Race.new
  f.each_line.with_index do |line, line_num|
    break if race.finished?
    next if line_num == 0 || line.chomp.length == 0

    fields = line.scan /(\S+)\s*/
    timestamp, pilot_code, dash, pilot_name, lap_num, lap_timing, avg_speed = fields.flatten 
    race.update_grid(lap_num)

    lap_timing_ms = LapData.convert_lap_timing_string(lap_timing)

    print line_num, " - ", pilot_code, " - ", lap_timing_ms, "\n"
    puts race.finished?
  end
end


puts "\u{1f3c1}  Terminada a corrida!"

