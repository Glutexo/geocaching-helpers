#!/usr/bin/ruby

=begin
Integery dostanou dvě nové funkce:
* ciferny_soucet provede jednorázový
  ciferný součet.
  Např. 128.ciferny_soucet = 11.
* ciferace provádí ciferný součet
  tak dlouho, dokud není výsledek
  pouze jednomístný.
  Např. 128.ciferace = 2.
=end

class Fixnum
  def ciferny_soucet
    soucet = 0
    self.to_s.each_char do |char|
      soucet += char.to_i
    end

    soucet
  end

  def ciferace
    cif = self
    begin
      cif = cif.ciferny_soucet
    end while cif.to_s.length > 1
    cif
  end
end

