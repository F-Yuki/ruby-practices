# frozen_string_literal: true

require 'optparse'

opt_a = nil
opt = OptionParser.new
opt.on('-a') { |v| opt_a = v }
opt.parse(ARGV)

dir = if opt_a
        Dir.glob('*', File::FNM_DOTMATCH)
      else
        Dir.glob('*')
      end

MAX_COLUMN_COUNT = 3
total_elements_count = dir.size
number_of_lines = (total_elements_count.to_f / MAX_COLUMN_COUNT).ceil(0)
last_line_lack_element_count = (MAX_COLUMN_COUNT - total_elements_count % MAX_COLUMN_COUNT).to_i

columns = []
if total_elements_count != 0
  dir.each_slice(number_of_lines) do |n|
    columns << n
  end
end

if !columns.empty? && columns.last.size != columns[0].size
  last_line_lack_element_count.times do
    columns.last << nil
  end
end

def show_files(dir, columns)
  transposed_columns = columns.transpose
  long_name = dir.max_by(&:size)
  margin = 3
  transposed_columns.each do |transposed_column|
    transposed_column.each do |f|
      print f.to_s.ljust(long_name.size + margin)
    end
    print "\n"
  end
end

show_files(dir, columns)
