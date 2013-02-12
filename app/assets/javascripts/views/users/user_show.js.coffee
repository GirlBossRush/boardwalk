class Boardwalk.Views.UsersNew extends Backbone.View

  template: JST['users/show']

  render: ->
    $(@el).html(@template())
    this