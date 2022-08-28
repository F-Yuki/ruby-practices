# frozen_string_literal: true

require 'optparse'
require 'etc'

opt_a = nil
opt = OptionParser.new
opt.on('-l') { |v| opt_a = v }
opt.parse(ARGV)

dir = if opt_a
        array = []
        Dir.glob('*').size.times{ |x|
          f = {"mode" => nil,"nlink" => nil,"owner" => nil,"group" => nil,"size" => nil,"mtime" => nil,"name" => nil}
          f["name"] = Dir.glob("*")[x]
          f[x] = {"mode" => nil,"nlink" => nil,"owner" => nil,"group" => nil,"size" => nil,"mtime" => nil,"name" => nil}

          def permission(mode)
              permission_table = {"7" => "rwx", "6" => "rw-", "5" => "r-x", "4" => "r--", "3" => "-wx", "2" => "-w-", "1" => "--x"}
              permission_table_1 = {"40" => "d", "10" => "-"}
              mode_1 = mode[-3..-1].chars.map { |c| permission_table[c] }.join
              mode_2 = permission_table_1[mode[0..1]]
              mode_2 + mode_1
          end

          if  FileTest.directory?(f["name"])
            f[x]["mode"] = permission(File::Stat.new(f["name"]).mode.to_s(8))
            f[x]["nlink"] = File::Stat.new(f["name"]).nlink.to_s
            f[x]["owner"] = Etc.getpwuid(File::Stat.new(f["name"]).uid).name
            f[x]["group"] = Etc.getgrgid(File::Stat.new(f["name"]).gid).name
            f[x]["size"] = File::Stat.new(f["name"]).size.to_s.rjust(4)
            f[x]["mtime"]=File::Stat.new(f["name"]).mtime.strftime("%-m %e %R")
            f[x]["name"] = f["name"]
          else  FileTest.file?(f["name"])
            f[x]["mode"] = permission(File::Stat.new(f["name"]).mode.to_s(8))
            f[x]["nlink"] = File::Stat.new(f["name"]).nlink.to_s
            f[x]["owner"] = Etc.getpwuid(File::Stat.new(f["name"]).uid).name
            f[x]["group"] = Etc.getgrgid(File::Stat.new(f["name"]).gid).name
            f[x]["size"] = File::Stat.new(f["name"]).size.to_s.rjust(4)
            f[x]["mtime"] = File::Stat.new(f["name"]).mtime.strftime("%-m %e %R")
            f[x]["name"] = f["name"]
          end
          array.push f[x].values
        }
        array.each { |a| puts a.join("  ") }
      else
        Dir.glob('*')
      end
