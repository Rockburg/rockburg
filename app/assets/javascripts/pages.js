App.room = App.cable.subscriptions.create("ActivityNotificationsChannel", {
  received(data) {
    location.reload();
    /*
    return $(
      'body[data-controller="bands"][data-action="show"][data-id="' +
        data["band"] +
        '"] .current_activity'
    ).fadeOut("fast", function() {
      $(".activities").fadeIn("fast");
      $(
        'body[data-controller="bands"][data-action="show"][data-id="' +
          data["band"] +
          '"] .data-fans'
      ).text(data["band_fans"]);
      $(
        'body[data-controller="bands"][data-action="show"][data-id="' +
          data["band"] +
          '"] .data-buzz'
      ).text(data["band_buzz"]);
      $(
        'body[data-controller="bands"][data-action="show"][data-id="' +
          data["band"] +
          '"] .data-balance'
      ).text(data["balance"]);

      return $(".activity_success")
        .html(data["message"])
        .fadeIn("fast", function() {
          $(this)
            .delay(3000)
            .fadeOut("slow");
          $(
            'body[data-controller="bands"][data-action="show"][data-id="' +
              data["band"] +
              '"] .news'
          ).load("/bands/" + data["band"] + "/happenings");
          return $(
            'body[data-controller="bands"][data-action="show"][data-id="' +
              data["band"] +
              '"] .allmembers'
          ).load("/bands/" + data["band"] + "/allmembers");
        });
    });
    */
  }
});
