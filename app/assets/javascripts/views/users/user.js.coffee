class Boardwalk.Views.User extends Backbone.View
  template: JST['users/user']
  tagName: 'tr'

  events:
    'click': 'showUser'

  render: ->
    $(@el).html(@template(user: @model))
    this

  showUser: ->
    Backbone.history.navigate("users/#{@model.get('_id')}", true)
