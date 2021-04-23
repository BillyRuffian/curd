require "curd/engine"
require "curd/configuration"
require "curd/version"

require 'cuke_modeler'
require 'fileutils'
require 'haml'
require 'tilt'

module Curd
  class Error < StandardError; end
  # Your code goes here...

  def self.doit
    # d = CukeModeler::Directory.new('')
    d = CukeModeler::Directory.new('')
    f = d.feature_files.first

    engine = Engine.new(configuration)
    engine.render(d)
  end

  def self.wotit
    d = CukeModeler::Directory.new('')
    f = d.feature_files.first
    s = f.feature.tests.first
    require 'pry'; binding.pry
    pp d.feature_files.map(&:name)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end
end
