require_relative 'huffman_nodes'

def build_huffman_tree(input_array, input_character_freq)
  q = []
  for i in 0..input_array.length
    new_node = HuffmanNode.new(input_array[i], input_character_freq[input_array[i]])
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
    elsif q.length == 1
      return JoinNode.new((z.freq + q[0].freq), z, q[0]) if z.freq <= q[0].freq
      return JoinNode.new((z.freq + q[0].freq), q[0], z) if z.freq > q[0].freq
    else
      q << z
    end
  end
end

def tree_traversal(node, code_index)
  if node.class == JoinNode
    node.left_child.code += "0"
    node.right_child.code += "1"
    node_traversal(node.left_child, code_index)
    node_traversal(node.right_child, code_index)
  else
    code_index[node.char] = node.code
  end
end

def huffman_compress(text)
  char_array = text.split('')
  char_freqs = {}
  char_array.each do |char|
    char_freqs[char] = 0 unless char_freqs.has_key?(char)
    char_freqs[char] += 1
  end
  first_node = build_huffman_tree(char_array, char_freqs)
  code_index = {}
  tree_traversal(first_node, code_index)
  compressed = ""
  char_array.each { |char| compressed << code_index[char] }
  return compressed
end

dna = "TAATTAGAAATTCTATTATA"
puts huffman_compress(dna)
