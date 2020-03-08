// App.activity_notifications = App.cable.subscriptions.create "ActivityNotificationsChannel",
//   connected: ->
//     # Called when the subscription is ready for use on the server
//
//   disconnected: ->
//     # Called when the subscription has been terminated by the server
//
//   received: (data) ->
//     # Called when there's incoming data on the websocket for this channel

App.notifications = App.cable.subscriptions.create(
  "ActivityNotificationsChannel",
  {
    connected: function() {},
    disconnected: function() {},
    received: function() {}
  }
);
