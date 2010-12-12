$('#stations a').click(function() {
  var jq_obj = $(this);
  options = {url:this.href};
  fetch_trains(options);
  return false;
});

function fetch_trains (options) {
  var results_list = $('#results');
  results_list.html('');
  $.getJSON(options.url,
    function(json) {
      $(json.results).each(function(index) {
        var li = $('<li></li>')
          .append($('<dl></dl>')
            .append('<dt>direction</dt><dd>'+this.direction+'</dd>')
            .append('<dt>service</dt><dd>'+this.service+'</dd>')
            .append('<dt>eta</dt><dd>'+this.eta+'</dd>')
            .append('<dt>scheduled</dt><dd>'+this.scheduled+'</dd>')
            .append('<dt>due</dt><dd>'+this.due+'</dd>')
            .append('<dt>service</dt><dd>'+this.service+'</dd>')
            .append('<dt>route</dt><dd>'+this.route+'</dd>')
            .append('<dt>info</dt><dd>'+this.info+'</dd>')
          );
        results_list.append(li);
      });
    }
  );
}