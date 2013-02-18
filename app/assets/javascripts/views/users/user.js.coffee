class Boardwalk.Views.User extends Backbone.View
  template: JST['users/user']
  tagName: 'tr'

  render: ->
    $(@el).html(@template(user: @model))
    this


