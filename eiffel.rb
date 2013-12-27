#!/usr/bin/ruby

=begin
Eiffelovka (GC4T25E)

Prints out all possible combination for the
clue ‘A’. It must have three figures and its
figure sum has to be 6. Only valid coordina-
tes are printed out.

DISCLAIMER:
This script does not solve the riddle and
does not calculate the final coordinates. It
only prints out all possible options, that
can be figured out from the listing.

If it is uncomfortable for the geocache au-
thor for this script to be publicly availa-
ble, please contact me at driezasson@me.com.
=end

require './solver.rb'

GeocacheSolver::combinations figure_count: 3,
                             figure_sum: 6,
                             transform_functions: { latitude: lambda { |x| x - 52 },
                                                    longitude: lambda { |x| x * 3  - 37 } },
                             coordinates: { latitude: { degrees: 49, minutes: 46 },
                                            longitude: { degrees: 18, minutes: 13 } }
