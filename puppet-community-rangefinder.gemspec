$:.unshift File.expand_path("../lib", __FILE__)
require 'rangefinder/version'
require 'date'

Gem::Specification.new do |s|
  s.name              = "puppet-community-rangefinder"
  s.version           = Rangefinder::VERSION
  s.date              = Date.today.to_s
  s.summary           = "Predicts downstream impact of breaking file changes."
  s.license           = 'Apache-2.0'
  s.email             = "ben.ford@puppet.com"
  s.authors           = ["Ben Ford"]
  s.require_path      = "lib"
  s.executables       = %w( rangefinder )
  s.files             = %w( README.md LICENSE CHANGELOG.md )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.add_dependency      "puppet",                  ">= 5.0", "<7.0"
  s.add_dependency      "google-cloud-bigquery",   "~> 1.0"

  s.description       = <<-desc
  Run this command with a space separated list of file paths in a module and it
  will infer what each file defines and then tell you what Forge modules use it.

  ******************************************************************************
  * Note that this is only useful by members of the Puppet Ecosystem team      *
  * because it uses BigQuery data that's not available publicly.               *
  ******************************************************************************

  Run `rangefinder --help` to get started.
  desc

end
