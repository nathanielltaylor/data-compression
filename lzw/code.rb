def lzw_compress(text)
  counter = 0
  dict = []
  output = []
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

string = "TATAGATCTTAATATA"
puts lzw_compress(string)
