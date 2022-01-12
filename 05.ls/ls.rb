# frozen_string_literal: true

dir = Dir.glob('*')

max_column_count = 3.0
total_files_count_and_total_directories_count = dir.size
number_of_lines = (total_files_count_and_total_directories_count.to_f / max_column_count).ceil(0)

files = []
dir.each_slice(number_of_lines) do |n|
  files << n
end

last_line_lack_element_count = (max_column_count - total_files_count_and_total_directories_count % max_column_count).to_i

if last_line_lack_element_count != 0
  last_line_lack_element_count.times do
    files.last << nil
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
