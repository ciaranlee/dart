$('#stations a').click(function() {
  var jq_obj = $(this);
  options = {url:this.href};
  fetch_trains(options);
  return false;
});

function fetch_trains (options) {
  var results_div = $('#results');
  results_div.html('');
  $.getJSON(options.url,
    function(json) {
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
    }
  );
}