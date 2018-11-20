class Rangefinder
  require 'json'
  require 'pathname'
  require 'rangefinder/bigquery'
  require 'rangefinder/parser'
  require 'rangefinder/version'

  def initialize(options)
    @options  = options
    @bigquery = Rangefinder::Bigquery.new(options)

    if options[:filenames].size == 1 and File.directory?(options[:filenames].first)
      options[:filenames] = Dir.glob("#{options[:filenames].first}/*")
    end

    @maxlen = options[:filenames].map {|f| File.basename(f).length }.max
  end

  def render!
    if @options[:render] == :summarize
      printf("%-#{@maxlen}s%12s%8s%6s\n", 'Item Name', 'Kind', 'Exact', 'Near')
      puts '=' * (@maxlen+26)
    end

    @options[:filenames].each do |filename|
      case File.extname(filename).downcase
      when '.pp'
        kind, name = Rangefinder::Parser::Puppet.new(filename).evaluate!
      when '.rb'
        kind, name = Rangefinder::Parser::Ruby.new(filename).evaluate!
      else
        $logger.info "Unknown file type: #{filename}"
        next
      end

      if kind.nil? or name.nil?
        $logger.info "Skipping #{filename}"
        next
      end

      results = @bigquery.find(namespace(filename), kind, name)

      case @options[:render]
      when :human
        puts pretty_print(results)
      when :summarize
        puts print_line(results)
      when :json
        puts JSON.pretty_generate(results)
      when :yaml
        require 'yaml'
        puts results.to_yaml
      else
        raise "Invalid render type (#{@options[:render]})."
      end
    end
  end

  # get the namespace of the module this file is located in.
  # doing it inside the loop is slower, but it means that we can check
  # files from multiple modules at once.
  def namespace(path)
    segments = Pathname(File.expand_path(path)).each_filename.to_a
    index    = segments.rindex {|item| ['lib','manifests'].include? item}

    return nil if index.nil?

    modroot  = segments[0...index]
    pathname = File.join([File::SEPARATOR, modroot, 'metadata.json'].flatten)
    metadata = JSON.parse(File.read(pathname)) rescue {}
    metadata['name']
  end

  def print_line(results)
    sprintf("%-#{@maxlen}s%12s%8d%6d\n", results[:name], results[:kind], results[:exact].size, results[:near].size)
  end

  def pretty_print(results)
    output  = "[#{results[:name]}] is a _#{results[:kind]}_\n"
    output << "==================================\n"

    if results[:exact].empty? and results[:near].empty?
      output << "with no external impact.\n\n"
    end

    unless results[:exact].empty?
      output << "Breaking changes to this file WILL impact these modules:\n"
      results[:exact].each do |row|
        output << "  * #{row[:module]} (#{row[:repo]})\n"
      end
      output << "\n"
    end

    unless results[:near].empty?
      output << "Breaking changes to this file MAY impact these modules:\n"
      results[:near].each do |row|
        output << "  * #{row[:module]} (#{row[:repo]})\n"
      end
      output << "\n"
    end

    output
  end

  def debug
    require 'pry'
    binding.pry
  end
end