require_relative 'lzw'

string = "TATAGATCTTAATAT"
compressed = lzw_compress(string)
puts compressed
decompressed = lzw_decompress(compressed)
puts decompressed
puts "Compression and decompression working" if decompressed == string
