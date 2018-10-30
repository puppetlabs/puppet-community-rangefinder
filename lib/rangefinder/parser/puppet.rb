require 'puppet'
require 'puppet/parser'

class Rangefinder::Parser::Puppet
  def initialize(filename)
    @filename = filename
    @parser   = Puppet::Pops::Parser::EvaluatingParser.new
  end

  def evaluate!
    source  = Puppet::FileSystem.read(@filename)
    result  = @parser.parse_string(source, @filename).definitions
    element = result.first

    $logger.error "The manifest contains multiple definitions; ignoring extras." unless result.size == 1

    [simpletype(element), element.name]
  end

  def simpletype(element)
    case element
    when Puppet::Pops::Model::HostClassDefinition
      :class
    when Puppet::Pops::Model::ResourceTypeDefinition
      :type
    when Puppet::Pops::Model::FunctionDefinition
      :function
    else
      $logger.info "Unknown element definition: #{element.class}"
      nil
    end
  end
end
