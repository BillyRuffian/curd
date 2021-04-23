module Curd
  class Configuration
    attr_accessor :template
    attr_accessor :output_dir

    def initialize
      @template = 'piccalilli'
      @output_dir = 'doc'
    end
  end
end