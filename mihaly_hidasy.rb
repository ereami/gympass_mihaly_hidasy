if ARGV.length < 1
  puts "Uso: ruby mihaly_hidasy.rb <nome_arquivo.log>"
  exit
end

File.open(ARGV.first, "r") do |f|
  f.each_line.with_index do |line, line_num|
    next if line_num == 0 || line.chomp.length == 0

    fields = line.scan /(\S+)\s*/
    timestamp, pilot_code, dash, pilot_name, lap_num, lap_timing, avg_speed = fields.flatten 

    lap_timing_parts = lap_timing.scan /(\d+):(\d+).(\d+)/
    min, s, ms = lap_timing_parts.flatten.map { |t| t.to_i }
    lap_timing_ms = (min * 60 + s) * 1000 + ms
    print line_num, " - ", pilot_code, " - ", lap_timing_ms, "\n"
  end
end

puts "\u{1f3c1}  Terminada a corrida!"
