require 'json'

def show(*args)
  puts args.map{ |a| a.to_s }.join(",")
end

tx, ty = nil, nil
i = 1
phrases = {}
$stdin.each_line do |line|
  score, titleX, titleY, x, preambleX, y, preambleY,
  p1score, p1text, p2score, p2text, p3score, p3text = line.chomp.split("\t")

  # if tx != titleX || ty != titleY
  #   tx, ty = titleX, titleY
  #   puts %{</pre>}
  #   puts %{<pre data-name="#{titleX}-#{titleY}" id="csv-#{i}">}
  #   i += 1
  # end


  show x.to_i, y.to_i, -(score.to_f.round(3))
  
  phrases[y] ||= {}
  phrases[y][x] = [
    [-p1score.to_f.round(3), p1text],
    [-p2score.to_f.round(3), p2text],
    [-p3score.to_f.round(3), p3text]
  ]
  
  # {
  #   score: score,
  #   titleX: titleX,
  #   titleY: titleY,
  #   x: x,
  #   y: y,
  # }
end

phrases.each_pair do |y, xs|
  File.open("data-#{y}.json", "w") do |file|
    file.puts("callback(" + xs.to_json + ")")
  end
end
# puts JSON::pretty_generate(phrases)
