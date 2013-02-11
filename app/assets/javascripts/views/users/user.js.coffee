class Boardwalk.Views.User extends Backbone.View
  template: JST['users/user']
  tagName: 'li'

  render: ->
    $(@el).html(@template(user: @model))
    this
