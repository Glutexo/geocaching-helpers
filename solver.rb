#!/usr/bin/ruby

require 'set'
require './ciferace.rb'

class GeocacheSolver
  DEFAULT_CARDINALS = { latitude: 'N',
                        longitude: 'E' }
  VALID_CARDINALS = { latitude: Set.new(['N', 'S']),
                      longitude: Set.new(['E', 'W']) }

  # Prints all possible coordinates for a mystery
  # geocache that uses only one clue. For the coor-
  # dinates to be figured out, we need to know the
  # figure count and the figure sum of the clue.
  # The clue is mathematically transformed by a
  # simple equation, whose solution are the thou-
  # sandths of the minute part of the coordinates
  # given in the N DD° MM.xxx E DD° MM.xxx format,
  # where the ‘xxx’ part are the thousandths com-
  # puted from the clue value.
  #
  # ‘args’ is a hash with following parameters:
  #   :figure_count [number] (mandatory)
  #   :figure_sum [number] (mandatory)
  #   :coordinates [hash] (mandatory) => {
  #     :latitude [hash] (mandatory) => {
  #       :cardinal [string, 'N' or 'S'] (optional, defaults to 'N'),
  #       :degrees [number] (mandatory),
  #       :minutes [number] (mandatory)
  #     },
  #     :longitude [hash] (mandatory) => {
  #       :cardinal [string, 'E' or 'W'] (optional, defaults to 'E'),
  #       :degrees [number] (mandatory),
  #       :minutes [number] (mandatory)
  #     }
  #   },
  #   :transform_functions [hash] (optional) => {
  #     :latitude [lambda] (optional),
  #     :longitude [lambda] (optional)
  #   }
  #
  def self.combinations args
    # Figure count is a mandatory argument.
    raise ArgumentError unless args.has_key? :figure_count
    figure_count = args[:figure_count]

    # Figure sum is a mandatory argument.
    raise ArgumentError unless args.has_key? :figure_sum
    figure_sum = args[:figure_sum]

    # Degrees and minutes are mandatory for both latitude
    # and longitude. Cardinal directions are optional,
    # defaults are north and east.
    raise ArgumentError unless args.has_key? :coordinates
    coordinates = { }
    [:latitude, :longitude].each do |lat_or_lon|
      raise ArgumentError unless args[:coordinates].has_key? lat_or_lon

      coordinates[lat_or_lon] = { }

      # Degrees and minutes are mandatory.
      [:degrees, :minutes].each do |deg_or_min|
        raise ArgumentError unless args[:coordinates][lat_or_lon].has_key? deg_or_min
        coordinates[lat_or_lon][deg_or_min] = args[:coordinates][lat_or_lon][deg_or_min]
      end

      # Cardinal direction is optional:
      # Default for latitude is north,
      # default for longitude is east.
      if args[:coordinates][lat_or_lon].has_key? :cardinal
        raise ArgumentError unless VALID_CARDINALS[lat_or_lon].include? args[:coordinates][:cardinal]
        coordinates[lat_or_lon][:cardinal] = args[:coordinates][lat_or_lon][:cardinal]
      else
        coordinates[lat_or_lon][:cardinal] =  DEFAULT_CARDINALS[lat_or_lon]
      end
    end


    # Transform function is optional:
    # If no function is given, the raw
    # value of the clue is used.
    no_transform = lambda { |i| i }
    transform_functions = { latitude: no_transform, longitude: no_transform }

    if args.has_key? :transform_functions
      [:latitude, :longitude].each do |lat_or_lon|
        if args[:transform_functions].has_key? lat_or_lon
          transform_functions[lat_or_lon] = args[:transform_functions][lat_or_lon]
        end
      end
    end

    # Create the range of all positive integers
    # that has the given figure count.
    bottom = 10 ** (figure_count - 1)
    top = 10 ** figure_count
    range = bottom...top

    thousands_range = 0...1000

    range.each do |clue_value|
      # Verify the figure sum of the clue value.
      next unless clue_value.figure_sum === figure_sum

      # Perform the mathematical transform from the
      # clue value to the thousandths of minutes to
      # be put into the coordinates.
      latitude_thousands = transform_functions[:latitude].call clue_value
      longitude_thousands = transform_functions[:longitude].call clue_value

      # Thousandths of minutes have to be positive
      # integres of three or less figures. Negative
      # numbers and numbers of four or more figures
      # are would produce invalid coordinates. That
      # would mean that the clue value is not the
      # right one.
      next unless thousands_range.include? latitude_thousands and
          thousands_range.include? longitude_thousands

      puts sprintf "%d: %s %02d° %02d.%03d %s %03d° %02d.%03d",
                   clue_value,
                   coordinates[:latitude][:cardinal],
                   coordinates[:latitude][:degrees],
                   coordinates[:latitude][:minutes],
                   latitude_thousands,
                   coordinates[:longitude][:cardinal],
                   coordinates[:longitude][:degrees],
                   coordinates[:longitude][:minutes],
                   longitude_thousands
    end
  end
end
