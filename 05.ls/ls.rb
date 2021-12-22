# frozen_string_literal: true

dir = Dir.glob('*')

max_column = 3.0
total_files = dir.size
number_of_lines = (total_files.to_f / max_column).ceil(0)

files = []
dir.each_slice(number_of_lines) do |n|
  files << n
end

if files.size >= max_column && total_files % max_column != 0
  (max_column - total_files % max_column).to_i.times do
    files[-1] << nil
  end
end

def show_files(dir, files)
  sort_files = files.transpose
  long_name = dir.max_by(&:size)
  margin = 3
  sort_files.each do |sort_file|
    sort_file.each do |f|
      print f.to_s.ljust(long_name.size + margin)
    end
    print "\n"
  end
end

show_files(dir, files)
