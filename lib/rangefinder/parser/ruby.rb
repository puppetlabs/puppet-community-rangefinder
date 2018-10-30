require 'pathname'

class Rangefinder::Parser::Ruby
  def initialize(filename)
    @filename = filename
  end

  def evaluate!
    case @filename
    when %r{lib/puppet/parser/functions/(\w+).rb}
      [:function, $1]
    when %r{lib/puppet/type/(\w+).rb}
      [:type, $1]
    when %r{lib/puppet/functions/(.*/)?(\w+).rb}
      function  = $2
      namespace = $1.gsub('/', '::') rescue nil
      [:function, "#{namespace}#{function}"]
    else
      $logger.info "Unknown file path: #{@filename}"
    end
  end
end
