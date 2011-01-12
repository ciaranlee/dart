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
            .append($('<dl></dl>')
              .append('<dt>service</dt><dd>'+this.trains[i].service+'</dd>')
              .append('<dt>eta</dt><dd>'+this.trains[i].eta+'</dd>')
              .append('<dt>scheduled</dt><dd>'+this.trains[i].scheduled+'</dd>')
              .append('<dt>due</dt><dd>'+this.trains[i].due+'</dd>')
              .append('<dt>route</dt><dd>'+this.trains[i].route+'</dd>')
              .append('<dt>info</dt><dd>'+this.trains[i].info+'</dd>')
            );
            ol.append(li);
        };
        direction_div.append(ol);
        results_div.append(direction_div);
      });
    }
  );
}