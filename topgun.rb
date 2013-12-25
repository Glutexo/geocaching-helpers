#!/usr/bin/ruby

require './ciferace.rb'

(1000..9999).each do |i|
  n = (i - 1531)
  e = (i - 680)
  if i.ciferny_soucet === 15 and
      n > 0 and
      e > 0 and
      n < 1000 and
      e < 1000
    puts sprintf "N 49°46.%03d E 018° 12.%03d", n, e
  end
end