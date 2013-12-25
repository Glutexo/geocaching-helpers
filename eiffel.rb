#!/usr/bin/ruby

=begin
Eiffelovka (GC4T25E)

Spočte veškerá možná řešení podle toho, co víme o
indicii: Je trojmísná a její ciferný součet je 6.
Dále po úpravách, po kterých se dosazuje hodnota
do souřadnic, musí být dosazované číslo stále
kladné a trojmístné, aby byly souřadnice platné.
=end

require './ciferace.rb'

# Všechna trojciferná čísla
# s cifernýcm součtem 6.
(100..999).each do |a|
  next unless a.ciferny_soucet === 6

  n = a - 52
  e = a * 3 - 37

  # Jen kladné a nejvýše trojmístné hodnoty,
  # tj. dosaditelné do souřadnic.
  next if n > 999 or e > 999 or n < 0 or e < 0

  puts sprintf "A = %d: N 49° 46.%03d E 018° 13.%03d", a, n, e
end