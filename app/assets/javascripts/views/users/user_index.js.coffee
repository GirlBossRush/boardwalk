class Boardwalk.Views.UsersIndex extends Backbone.View

  template: JST['users/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(@collection))
    @collection.each(@appendUser)
    this

  appendUser: (user) =>
    view = new Boardwalk.Views.User(model: user)
    @$("#users").append(view.render().el)
    $('time').timeago()