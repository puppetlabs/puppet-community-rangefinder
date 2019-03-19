class Rangefinder
  require 'json'
  require 'pathname'
  require 'rangefinder/bigquery'
  require 'rangefinder/parser'
  require 'rangefinder/version'

  def initialize(options)
    options[:filenames] ||= [] # don't blow up if we're called with no files

    @options  = options
    @bigquery = Rangefinder::Bigquery.new(options)

    if options[:filenames].size == 1 and File.directory?(options[:filenames].first)
      options[:filenames] = Dir.glob("#{options[:filenames].first}/**/*")
    end
  end

  def render!
    results = analyze(@options[:filenames]).compact
    @maxlen = (results.map {|res| res[:name].length} + [12]).max # Take into account the 'item name' label

    if @options[:render] == :summarize
      printf("%-#{@maxlen}s %-12s %-8s %-7s %-12s\n", 'Item Name', 'Kind', 'Exact', 'Near', 'Puppetfiles')
      puts '=' * (@maxlen+42)
    end

    results.each do |item|
      case @options[:render]
      when :human
        puts pretty_print(item)
      when :summarize
        puts print_line(item)
      when :json
        puts JSON.pretty_generate(item)
      when :yaml
        require 'yaml'
        puts item.to_yaml
      else
        raise "Invalid render type (#{@options[:render]})."
      end
    end
  end

  def analyze(files)
    files.map do |filename|
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

      @bigquery.find(namespace(filename), kind, name)
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
    sprintf("%-#{@maxlen}s %-12s %-8s %-7s %-12s\n",
            results[:name],
            results[:kind],
            results[:exact].size,
            results[:near].size,
            results[:puppetfile])
  end

  def pretty_print(results)
    output  = "[#{results[:name]}] is a _#{results[:kind]}_\n"
    output << "==================================\n"

    if results[:exact].empty? and results[:near].empty?
      output << "with no external impact.\n\n"
    end

    unless results[:puppetfile].empty?
      output << "The enclosing module is declared in #{results[:puppetfile]} indexed public Puppetfiles\n\n"
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
