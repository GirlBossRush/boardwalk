class Boardwalk.Views.UsersIndex extends Backbone.View

  template: JST['users/index']

  initialize: ->
    @collection.on 'reset', @render, @
    @collection.on 'add', @appendUser, @

  events:
    'click .id': 'showUser'

  render: ->
    $(@el).html(@template(@collection))
    @collection.each(@appendUser)
    this

  appendUser: (user) =>
    view = new Boardwalk.Views.User(model: user)
    @$("#users").append view.render().el
    @$('time').timeago()

  showUser: (e) ->
    e.preventDefault()
    id = $(e.target).data('id')

    user = new Boardwalk.Models.User({id})
    user.show()
