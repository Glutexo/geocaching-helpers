#!/usr/bin/ruby

require './ciferace.rb'

# Všechna trojciferná čísla
# s cifernýcm součtem 6.
(100..999).each do |a|
  next unless a.ciferny_soucet === 6

  n = a - 52
  e = a * 3 - 37

  next if n > 999 or e > 999 or n < 0 or e < 0

  puts sprintf"N 49° 46.%03d E 018° 13.%03d", n, e
end