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
    slug = $(e.target).data('username')
    Backbone.history.navigate("users/#{slug}", true)

