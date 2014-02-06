#!/usr/bin/ruby -w

def usage ()
  puts "Hang on for usage"
end

def read_options_from_file (options, filename)
  begin
    File.open(filename,'r') { |file|
      file.each() { |line|
        if options[line.split[0]]
          options[line.split[0]] = line.split[1];
        end
      }
    }
  rescue
    raise "No file " + filename
  end
end

def write_options_to_file (options, filename)
  File.open(filename,'w') { |file|
    options.each() { |key, value|
      puts "#{key} #{value}"
    }
  }
end

filename = "selection.opt"

options = {
  "min_nvar" => 1,
  "max_nvar" => 1e9.to_i,
  "min_ncon" => 0,
  "max_ncon" => 1e9.to_i
}

puts "Selecting options from the file " + filename
begin
  read_options_from_file(options, filename)
rescue
  puts "Do you want to create the file " + filename + 
      " with the default options? (Y/n)"
  yn = gets.chomp.downcase
  if (yn == '')
    yn = 'y'
  end
  if (yn == 'y')
    write_options_to_file(options, filename)
  elsif (yn != 'n')
    puts "Option unidentified"
  end
end

puts options

f = File.open("sif.url","r")

f.each { |line| 
  name = line.split[0]
  nvar = line.split[1].to_i
  ncon = line.split[2].to_i

  if (options["min_nvar"].to_i <= nvar &&
      nvar <= options["max_nvar"].to_i &&
      options["min_ncon"].to_i <= ncon &&
      ncon <= options["max_ncon"].to_i)
    puts name
  end
}

f.close()