// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require_tree .

$(document).ready(function() {
  $(".modal.bankrupt").modal({
    backdrop: "static",
    keyboard: false,
    show: true
  });

  $("[data-endtimes]").each(function() {
    var $this = $(this),
      finalDate = $(this).data("endtimes");
    $this.countdown(finalDate, function(event) {
      var str = "";
      // if 0 number of days, show H:M:S
      if (parseInt(event.strftime("%D")) == 0) {
        str = event.strftime("%-H hour%!H %-M minute%!M %-S second%!S");
        // if 0 days 0 hours, show M:S
        if (parseInt(event.strftime("%H")) == 0) {
          str = event.strftime("%-M minute%!M %-S second%!S");
          // if 0 days 0 hours 0 minutes, show only Seconds
          if (parseInt(event.strftime("%M")) == 0) {
            str = event.strftime("%-S second%!S");
          }
        }
      } else {
        str = event.strftime(
          "%-D day%!D %-H hour%!H %-M minute%!M %-S second%!S"
        );
      }
      $(this).html(str);
    });
  });
});
