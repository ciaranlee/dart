$('#stations a').click(function() {
  $('#results').html('<h2>loading...</h2>');
  var jq_obj = $(this);
  options = {url:this.href};
  fetch_trains(options);
  window.location = "#results";
  return false;
});

function fetch_trains (options) {
  var results_div = $('#results');
  $.getJSON(options.url,
    function(json) {
      results_div.html('');
      if (typeof(json.results) != "undefined") {
        $(json.results).each(function(index) {
          var direction_div = $('<div class="direction"><h2>'+this.direction+'</h2></div>');
          var ol = $('<ol></ol>');
          for (var i=0; i < this.trains.length; i++) {
            var li = $('<li></li>')
                .append('<dl><dt class="onecol">service</dt><dd>'+this.trains[i].service+'</dd><dl>')
                .append('<dl><dt class="onecol">eta</dt><dd>'+this.trains[i].eta+'</dd><dl>')
                .append('<dl><dt class="onecol">scheduled</dt><dd>'+this.trains[i].scheduled+'</dd><dl>')
                .append('<dl><dt class="onecol">due</dt><dd>'+this.trains[i].due+'</dd><dl>')
                .append('<dl><dt class="onecol">route</dt><dd>'+this.trains[i].route+'</dd><dl>')
                .append('<dl><dt class="onecol">info</dt><dd>'+this.trains[i].info+'</dd><dl>');
              ol.append(li);
          };
          direction_div.append(ol);
          results_div.append(direction_div);
        });
      } else{
        results_div.html('<h2>No trains</h2>');
      };
    }
  );
}