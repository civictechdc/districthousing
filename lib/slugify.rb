# Turn a string into something suitable for basing a filename on.
module Slugify
  def self.slugify str
    str.gsub(/[^0-9A-Za-z.\-]/, '_')
  end
end
