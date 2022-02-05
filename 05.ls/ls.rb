# frozen_string_literal: true

dir = Dir.glob('*')

max_column_count = 3.0
total_elements_count = dir.size
number_of_lines = (total_elements_count.to_f / max_column_count).ceil(0)

files = []
if number_of_lines == 0
    return
else
  dir.each_slice(number_of_lines) do |n|
    files << n
  end
end

last_line_lack_element_count = (max_column_count - total_elements_count % max_column_count).to_i

if files.size >= max_column_count && total_elements_count % max_column_count != 0
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
