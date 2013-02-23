class Boardwalk.Views.UsersShow extends Backbone.View

  template: JST['users/show']

  render: ->
    $(@el).html(@template(user: @model))
    this
