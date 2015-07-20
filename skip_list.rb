module SkipList
  class Node
    attr_accessor :forwards, :value

    def initialize value, level
      @value = value
      forwards = Array.new level + 1
    end
  end

  class SkipList
    attr_accessor :header, :max_level

    def initialize max_level
      @max_level = max_level
      @header = Node.new nil, max_level
      sentinel = Node.new Float::INFINITY, max_level
      @header.forwards = Array.new max_level + 1, sentinel 
    end
  end
end
