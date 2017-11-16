var currencyFormatter = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD',
  minimumFractionDigits: 0
});

$(document).ready(function() {
  var kwForm = $('#kw-form');
  var kwQuery = $('#kw-query');

  var keywordsSet = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: kwForm.data('autocomplete-url') + '.json?q=%QUERY',
      wildcard: '%QUERY'
    }
  });

  kwQuery.typeahead({
    minLength: 0,
    highlight: true
  }, {
    name: 'keywords',
    source: keywordsSet
  });



  $('#chart').highcharts({
    chart: {
      type: 'spline'
    },
    title: {
      text: 'Gross amount of money made by movies with keywords by year (adjusted for inflation)',
      x: -20 //center
    },
    subtitle: {
      text: 'Source: IMDb.com',
      x: -20
    },
    xAxis: {
      title: {
        text: 'Year'
      }
    },
    yAxis: {
      title: {
          text: 'Amount'
      },
      plotLines: [{
          value: 0,
          width: 1,
          color: '#808080'
      }]
    },
    tooltip: {
      useHTML: true,
      formatter: function(  ) {
        var point = this.point;
        var header = "<b>"+point.x+"</b> "+currencyFormatter.format(point.y)+" USD";
        
        $.getJSON(kwForm.data('dataset-url') + "/" + this.series.name + "/" + point.x, function(data){
            var html = header + "<br /><br /><table>";
            html += _.join(_.map(data, function(d) {
              return "<tr><td>"+d.title+"</td><td>"+currencyFormatter.format(d.amount)+"</td></tr>";
            }), "");
            html += "</table>";

            var tt = point.series.chart.tooltip;
            console.log(tt);
            tt.label.textSetter(html);
        });
        return header;
      }

    },

    

    plotOptions: {
        spline: {
            marker: {
                enabled: true
            }
        }
    },

    series: []
  });

  
  kwForm.submit(function(e) {
    e.preventDefault();

    $.getJSON(kwForm.data('dataset-url') + "/" + $('#kw-query').val(), function(dataset) {
      kwForm[0].reset();
      kwQuery.typeahead('close');

      $('#chart').highcharts().addSeries({
        name: dataset.word,
        data: _.map(dataset.data, function(k, w) {
          return [parseInt(w), parseInt(k)];
        })
      });
    });
  });

});
