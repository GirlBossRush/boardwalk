class FlashMessenger extends Backbone.Model
  constructor: ->
      @messages = []

    # add a message to the messages array
    add: (type, message) ->
      @messages.push
        type: type
        message: message

    # returns all existing messages and clearing all messages
    getMessages: ->
      ret = @messages.slice(0)
      @messages = []
      return ret