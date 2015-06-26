KJV = ENV['KJV'] || '/Users/duane/Projects/wordtree/research/kjv.txt'

kjv = File.read(KJV)
lines = kjv.split("\r\n")[1..-1]; nil
counts = lines.map{ |l| ref, line = l.split(/\s/, 2); [ref, line.split(/\s+/).size] }; nil
total_words = counts.inject(0){ |sum, c| sum += c[1] }

wg = 1070
idx = []
words_so_far = 0
count_index = 0
j = 0

(wg..(total_words+wg)).step(wg) do |i|
  while words_so_far < i && count_index < counts.size
    words_so_far += counts[count_index][1]
    count_index += 1
  end
  c = counts[count_index-1]
  idx << [c[0], j]
  j += 1
end

require 'json'
puts idx.to_json
