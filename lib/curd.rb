require "curd/engine"
require "curd/configuration"
require "curd/tree"
require "curd/version"

require 'cgi'
require 'cuke_modeler'
require 'fileutils'
require 'haml'
require 'tilt'

module Curd
  class Error < StandardError; end

  def self.wotit
    d = CukeModeler::Directory.new('')
    f = d.feature_files.first
    s = f.feature.tests.first
    require 'pry'; binding.pry
    pp d.feature_files.map(&:name)
  end

  def self.process(path)
    input_dir = CukeModeler::Directory.new(path)
    engine.render(input_dir)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  def self.engine
    @engine ||= Curd::Engine.new(configuration)
  end
end
