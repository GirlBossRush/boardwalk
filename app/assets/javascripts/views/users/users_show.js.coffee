class Boardwalk.Views.UsersShow extends Backbone.View
  tagName: 'section'
  attributes:
    class: 'board'
  template: JST['users/show']

  render: ->
    $(@el).html(@template(user: @model))
    @collection.each(@appendWidget)
    this

  appendWidget: (widget) =>
    view = new Boardwalk.Views.Widget(model: widget)
    @$("#widget-content").append view.render().el
    @$('time').timeago()