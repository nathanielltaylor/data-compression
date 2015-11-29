class HuffmanNode
  attr_reader :freq
  def initialize(char, freq)
    @char = char
    @freq = freq
  end
end

class JoinNode
  attr_reader :freq
  def initialize(freq, left_child, right_child)
    @freq = freq
    @left_child = left_child
    @right_child = right_child
  end
end

def build_huffman_tree(input_array, input_character_freq)
  q = []
  for i in 0..input_array.length
    new_node = HuffmanNode.new(input_array[i], input_character_freq[i])
    q << new_node
  end
  for i in 0..(input_array.length - 1)
    x = q.min_by { |node| node.freq }
    q.delete(x)
    y = q.min_by { |node| node.freq }
    q.delete(y)
    z = JoinNode.new((x.freq + y.freq), x, y)
    if q.empty?
      return z
    else
      q << z
    end
  end
end
