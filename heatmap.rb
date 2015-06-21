require 'json'

def make_chart(
    title: "Chart", subtitle: nil, 
    xtitle: nil, ytitle: nil,
    placeholder: 'PLACEHOLDER', height: 400)

  tooltip_formatter = "function() { return '' + this.point.count + ' occurrences / ' + this.point.total + ' total words' }"

  xlabels, ylabels, data = [], [], []
  for x in 1..300
    for y in 1..300
      xlabels << x
      ylabels << y
      data << [x-1, y-1, x*y]
    end
  end

  {
    chart: {
      renderTo: "|div|",
      height: height,
      type: 'heatmap'
    },
    title: {
      text: title,
      x: -20
    },
    subtitle: {
      text: subtitle,
      x: -20
    },
    xAxis: {
      # categories: xlabels,
      title: { text: xtitle }
    },
    yAxis: {
      min: 0,
      # categories: ylabels,
      title: { text: ytitle }
    },
    colorAxis: {
      # min: 0,
      # minColor: '#FFFFFF',
      # maxColor: "|Highcharts.getOptions().colors[0]|"
      stops: [
          [0, '#3060cf'],
          [0.5, '#fffbbc'],
          [0.9, '#c4463a'],
          [1, '#c4463a']
      ],
      startOnTick: false,
      endOnTick: false,
      labels: {
          format: 'Score: {value}'
      }
    },
    tooltip: {
      formatter: "|#{tooltip_formatter}|"
    },
    legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'middle',
      borderWidth: 0
    },
    series: [{
      data: data,
      dataLabels: {
        enabled: true,
        color: '#000000'
      }
    }]
  }
end

def script_chart(**args)
  "<script>\n" +
    "var div = document.createElement('div'), " +
        "script = document.scripts[document.scripts.length - 1]; " +
    "script.parentElement.insertBefore(div, script); " +
    "new Highcharts.Chart(" + 
      make_chart(**args).to_json.gsub(/"\|(.+?)\|"/, '\\1') +
    ");\n</script>"
end

puts script_chart(
  title: "Heatmap"
)