#!/usr/bin/ruby

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

