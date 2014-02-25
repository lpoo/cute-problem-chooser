#!/usr/bin/ruby -w

def usage (options)
  puts "Usage: ./selectproblems.rb --<option> <value>"
  puts "  Where <option> is one of the following:"
  options.each { |key,value|
    puts "   - #{key}"
  }
end

def all_in_options (option, array, options)
  unless (options[option])
    raise "Option `#{option}` does not exist"
  end
  array.each { |v|
    unless (options[option].include?(v))
      return false
    end
  }
  true
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
      printf(file, "%s %s\n", key, value);
    }
  }
end

def parse_options_from_argv (options, argv)
  argv.each_slice(2) do |option, value|
    option = option[/[^-].*/]
    if 'h,help,usage'.include?(option)
      usage(options)
      exit
    end
    unless options[option]
      raise "Option `#{option}` does not exist"
    end
    options[option] = value;
  end
end

filename = "options.rc"

options = {
  "min_nvar" => 1,
  "max_nvar" => 1e9.to_i,
  "min_ncon" => 0,
  "max_ncon" => 1e9.to_i,
  "linearity" => "lincon,nlncon",
  "constr_type" => "unc,equ,inq,gen",
  "bounds" => "boxed,lower,upper,nobnd",
  "fixed_var" => "fixed,nofix",
  "use_slack" => "true,false"
}

#puts "Selecting options from the file " + filename
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

parse_options_from_argv(options, ARGV)

#options.each { |key,value|
  #puts "#{key} => #{value}"
#}

class_file = File.open("sif.bsc","r")
decoder_file = File.open("sif.dcd","r")
list_file = File.open("problem.list","w")

class_file.each.zip(decoder_file.each).each do |line1, line2|
  name = line1.split[0]

  if (name != line2.split[0])
    raise "#{name} not equal #{line2.split[0]}"
  end

  nvar = line2.split[1].to_i
  nconE = line2.split[2].to_i
  nconI = line2.split[3].to_i
  constr = line2.split[4].split(',')
  linear = line2.split[5].split(',')
  bound  = line2.split[6].split(',')
  fixed  = line2.split[7].split(',')

  if (options["use_slack"] == "true")
    nvar += nconI
  end
  ncon = nconE + nconI

  if (options["min_nvar"].to_i <= nvar &&
      nvar <= options["max_nvar"].to_i &&
      options["min_ncon"].to_i <= ncon &&
      ncon <= options["max_ncon"].to_i &&
      all_in_options("constr_type", constr, options) &&
      all_in_options("linearity", linear, options) &&
      all_in_options("bounds", bound, options) &&
      all_in_options("fixed_var", fixed, options) )
    printf(list_file, "%s\n", name)
  end
end

list_file.close()
decoder_file.close()
class_file.close()
