require_relative 'huffman'

input = "TAATTAGAAATTCTATTATA"

compression = huffman_compress(input)
code = compression[:compression]
puts code

output = huffman_decompress(code, compression[:code_index])
puts output

puts "Compression and decompression working" if input == output
