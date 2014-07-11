require "securerandom"

module Newcomb
  def self.random_number(n = 0)
    if n > 0
      (random_number * n).floor
    else
      (10 ** SecureRandom.random_number - 1) / 9
    end
  end
end
