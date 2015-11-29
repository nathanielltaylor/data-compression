class HuffmanNode
  attr_reader :freq, :char
  attr_accessor :code
  def initialize(char, freq, code = "")
    @char = char
    @freq = freq
    @code = code
  end
end

class JoinNode
  attr_reader :freq, :left_child, :right_child
  attr_accessor :code
  def initialize(freq, left_child, right_child, code = "")
    @freq = freq
    @left_child = left_child
    @right_child = right_child
    @code = code
  end
end
