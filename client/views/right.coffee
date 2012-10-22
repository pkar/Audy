root = global ? window

Meteor.subscribe("messages")

root.Template.messages.messages = () ->
  Messages.find({}, {sort: { time: -1 }})

root.Template.chat.events =
  "keydown #chat-message": (event) ->

    if event.which is 13
      message = $('#chat-message').val()

      if not _.isEmpty(message)
        user = Meteor.user()
        userName = user?.profile?.name or user?.emails[0]?.address
        Messages.insert
          name: userName
          message: message
          time: Date.now()

        Meteor.flush()
        $('#chat-message').val('')
