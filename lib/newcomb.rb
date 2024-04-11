# frozen_string_literal: true

require "securerandom"

# The Newcomb module is the interface to its random_number function which is
# designed to behave identically to SecureRandom.random_number except for the
# distribution of its return values. Like SecureRandom, the
# Newcomb.random_number function can be given a single argument in one of the
# following forms:
#
#   Integer - The random number returned will be an Integer between 0 and the
#             given maximum, exclusive.
#   Float   - The random number returned will be a Float between 0.0 and the
#             given maximum, exclusive.
#   Range   - The random number returned will be either an Integer or Float,
#             depending on the endpoints of the range, and within the range.
module Newcomb
  # The 3-element "constraints" array represents the minimum allowed value,
  # the maximum allowed value, and whether the final value should be rounded
  # down to the nearest integer.
  DEFAULT_CONTRAINTS = [0, 1, false].freeze

  def self.random_number(arg = nil)
    random_factor = ((10 ** SecureRandom.random_number) - 1) / 9
    min, max, round = generate_constraints(arg)
    float_value = (random_factor * (max - min)) + min
    round ? float_value.floor : float_value
  end

  def self.generate_constraints(arg)
    case arg
    when nil then DEFAULT_CONTRAINTS
    when Range then generate_constraints_from_range(arg)
    when Integer, Float then generate_constraints_from_max(arg)
    else invalid_argument!(arg)
    end
  end

  def self.generate_constraints_from_range(range)
    first = range.first
    last = range.last

    # The given range must have integer/float endpoints.
    unless (first.is_a?(Integer) || first.is_a?(Float)) && (last.is_a?(Integer) || last.is_a?(Float))
      invalid_argument!(range)
    end

    if first < last
      # We only round the final value down if both endpoints of the range
      # are integers, mirroring the behavior of SecureRandom.random_number.
      [first, last, first.is_a?(Integer) && last.is_a?(Integer)]
    else
      DEFAULT_CONTRAINTS
    end
  end

  def self.generate_constraints_from_max(max)
    if max.positive?
      [0, max, max.is_a?(Integer)]
    else
      DEFAULT_CONTRAINTS
    end
  end

  def self.invalid_argument!(arg)
    raise ArgumentError, "invalid argument - #{arg}"
  end
end
