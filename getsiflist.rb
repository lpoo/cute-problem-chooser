#!/usr/bin/ruby -w

def case_objfun (objfun)
  case objfun
  when "N"
    "notdef"
  when "C"
    "cnstnt"
  when "L"
    "linear"
  when "Q"
    "quadrt"
  when "S"
    "sumsqr"
  when "O"
    "others"
  else
    raise objfun + " is not in the expected cases"
  end
end

def case_constr (constr)
  case constr
  when "U"
    "unc"
  when "X"
    "fix"
  when "B"
    "bnd"
  when "N"
    "net"
  when "L"
    "lin"
  when "Q"
    "qdt"
  when "O"
    "oth"
  else
    raise constr + " is not in the expected cases"
  end
end

def case_regular (regular)
  case 
  when "R"
    "reg"
  when "I"
    "irr"
  else
    raise regular + " is not is the expected cases"
  end
end

# Alternative: Use classall to obtain a similar content
require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open('http://www.cuter.rl.ac.uk/Problems/mastsif.shtml'))
td = doc.xpath("//td")

f = File.open("sif.bsc","w")

begin
  td.each_slice(3) { |a| 
    name = a[0].content.strip
    #Temporary fix on CKOEHELB
    if (name == "CKOEHELB")
      next
    end
    classification = a[2].content.strip.split('-')

    begin
      objfun  = case_objfun(classification[0][0])
      constr  = case_constr(classification[0][1])
      regular = case_regular(classification[0][2])
    rescue Exception => e
      puts "In line " + a[0].content.strip + " " + a[2].content.strip
      raise e.message
    end
    deriv   = classification[0][3]

    origin   = classification[1][0]
    internal = classification[1][1]

    nvar = classification[2]
    ncon = classification[3]


    printf(f, "%-9s %9s %9s %6s %3s %3s %s %s %s\n", name, nvar, ncon, objfun, constr, regular,
      deriv, origin, internal)
  }
ensure
  f.close
end
