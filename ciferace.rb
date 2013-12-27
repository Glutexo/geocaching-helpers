#!/usr/bin/ruby

=begin
Two new methods for integers, useful
for solving mystery-caches.
* figure_sum
  E.g. 128.figure_sum = 11.
* recursive_figure_sum does the figure
  sum again and again, until the result
  has only one figure.
  E.g. 128.recursive_figure_sum = 2.
=end

class Fixnum
  def figure_sum
    soucet = 0
    self.to_s.each_char do |char|
      soucet += char.to_i
    end

    soucet
  end

  def recursive_figure_sum
    cif = self
    begin
      cif = cif.figure_sum
    end while cif.to_s.length > 1
    cif
  end
end

