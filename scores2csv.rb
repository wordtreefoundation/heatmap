require 'json'

def show(*args)
  puts args.map{ |a| a.to_s }.join(",")
end

tx, ty = nil, nil
i = 1
$stdin.each_line do |line|
  score, titleX, titleY, x, preambleX, y, preambleY = line.chomp.split("\t")

  if tx != titleX || ty != titleY
    tx, ty = titleX, titleY
    puts %{</pre>}
    puts %{<pre data-name="#{titleX}-#{titleY}" id="csv-#{i}">}
    i += 1
  end

  show (x.to_i-1), (y.to_i-1), -(score.to_f.round(3))
  # {
  #   score: score,
  #   titleX: titleX,
  #   titleY: titleY,
  #   x: x,
  #   y: y,
  # }
end

# puts JSON::pretty_generate(data)
