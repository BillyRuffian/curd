module Curd
  
  class Tree
    include Comparable 

    attr_accessor :value
    attr_accessor :children
    attr_accessor :leaves

    def initialize(value)
      @value = value
      @children = []
      @leaves = []
    end

    def <=>(other)
      value <=> other.value
    end

    def build(*leaves)
      child_value = leaves.shift
      child = children.find { |c| c.value == child_value }
      children << (child = Tree.new(child_value)) unless child
      child = child.build(*leaves) unless leaves.empty?
      child
    end
  end
end