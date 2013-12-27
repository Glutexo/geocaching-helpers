#!/usr/bin/ruby

=begin
TOP GUN (GC4T71V)

Prints out all possible combination for the
clue ‘R’. It must have four figures and its
figure sum has to be 15. Only valid coordi-
nates are printed out.

DISCLAIMER:
This script does not solve the riddle and
does not calculate the final coordinates.
It only prints out all possible options,
that can be figured out from the listing.

If it is uncomfortable for the geocache
author for this script to be publicly
available, please contact me at
driezasson@me.com.
=end

require './solver.rb'

GeocacheSolver::combinations figure_count: 4,
                             figure_sum: 15,
                             transform_functions: { latitude: lambda { |x| x - 1531 },
                                                    longitude: lambda { |x| x - 680 } },
                             coordinates: { latitude: { degrees: 49, minutes: 46 },
                                            longitude: { degrees: 18, minutes: 12 } }