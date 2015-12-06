def lzw_compress(text)
counter, dict, output = 0, [], []
  256.times do
    dict[counter] = counter.chr
    counter += 1
  end
  position = 0
  s = text[position]
  while position < (text.length - 1)
    c = text[position + 1]
    if dict.include?(s + c)
      s = s + c
    else
      output << dict.index(s)
      dict << (s + c)
      s = c
    end
    position += 1
  end
  output << dict.index(s)
  output
end

def lzw_decompress(indices)
  counter, dict, output = 0, [], []
  256.times do
    dict[counter] = counter.chr
    counter += 1
  end
  current = indices[0]
  output << dict[current]
  indices.drop(1).each do |index|
    previous = current
    current = index
    if !dict[current].nil?
      s = dict[current]
      output << s
      dict << (dict[previous] + s[0])
    else
      s = (dict[previous] + dict[previous][0])
      output << s
      dict << s
    end
  end
  output.join
end
