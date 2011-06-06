module Rake
  module Version
    NUMBERS = [
      MAJOR = 0,
      MINOR = 9,
      BUILD = 0,
    ]
  end
  VERSION = Version::NUMBERS.join('.')
end
