#!/usr/bin/ruby

=begin
TOP GUN (GC4T71V)

Spočte všechny možné a platné kombinace pro
číslo R o kterém víme, že je čtyřciferné
a že jeho ciferný součet je 15. Po úpravě
na hodnoty dosazované do souřadnic musejí
být tyto hodnoty kladné a troj-, nebo méně-
ciferné.
=end

require './ciferace.rb'

# Všechna čtyřciferná čísla, jejichž
# ciferný součet je 15.
(1000..9999).each do |r|
  next unless r.ciferny_soucet === 15

  n = r - 1531
  e = r - 680

  # Hodnoty dosazované do souřadnic musejí být
  # kladné a nejvýš trojciferné.
  next if n > 999 or e > 999 or n < 0 or e < 0

  puts sprintf "R = %d: N 49°46.%03d E 018° 12.%03d", r, n, e
end