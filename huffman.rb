require_relative 'huffman_nodes'

def get_frequencies(char_array, char_freqs)
  char_array.each do |char|
    char_freqs[char] = 0 unless char_freqs.has_key?(char)
    char_freqs[char] += 1
  end
end

def build_huffman_tree(input_array, character_freq)
  q = []
  accounted_for = []
  for i in 0..(input_array.length - 1)
    if !accounted_for.include?(input_array[i])
      new_node = HuffmanNode.new(input_array[i], character_freq[input_array[i]])
      q << new_node
      accounted_for << input_array[i]
    end
  end
  for i in 0..(input_array.length - 1)
    x = q.min_by { |node| node.freq }
    q -= [x]
    y = q.min_by { |node| node.freq }
    q -= [y]
    z = JoinNode.new((x.freq + y.freq), x, y)
    if q.empty?
      return z
    else
      q << z
    end
  end
end

def tree_traversal(node, code_index)
  if node.class == JoinNode
    node.left_child.code = node.code + "0"
    node.right_child.code = node.code + "1"
    tree_traversal(node.left_child, code_index)
    tree_traversal(node.right_child, code_index)
  else
    code_index[node.char] = node.code
  end
end

def huffman_compress(text)
  char_array = text.split('')
  char_freqs = {}
  get_frequencies(char_array, char_freqs)
  first_node = build_huffman_tree(char_array, char_freqs)
  code_index = {}
  tree_traversal(first_node, code_index)
  compressed = ""
  char_array.each { |char| compressed << code_index[char] }
  { compression: compressed.unpack("B*")[0], code_index: code_index }
end

def huffman_decompress(code, code_index)
  code = [code].pack("B*")
  code_index = code_index.invert
  decompressed = ""
  cache = ""
  while code.length > 0
    cache += code.slice!(0)
    if code_index.has_key?(cache)
      decompressed += code_index[cache]
      cache = ""
    end
  end
  decompressed
end
