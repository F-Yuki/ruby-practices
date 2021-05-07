require "date"
require "optparse"

day = Date.today
choice = ARGV.getopts("y:", "m:")

if choice["y"]
  year = choice["y"].to_i
else
  year = day.year
end

if choice["m"]
  month = choice["m"].to_i
else
  month = day.month
end

top = Date.new(year, month, 1).strftime("%B %Y")
firstday = Date.new(year, month, 1)
lastday = Date.new(year, month, -1)
week = %w(日 月 火 水 木 金 土)

puts top.center(20)
puts week.join(" ")
print "   " * firstday.wday

(firstday..lastday).each do |date|
  # 何か出力する
  print date.day.to_s.rjust(2) + " "
  # 土曜日だったら改行する
  puts if date.saturday?
end
puts
