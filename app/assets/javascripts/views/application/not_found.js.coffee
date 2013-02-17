class Boardwalk.Views.NotFound extends Backbone.View

  template: JST['application/not_found']

  render: (params) ->
    $(@el).html(@template(params))
    this
