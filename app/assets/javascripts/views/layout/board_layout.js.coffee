class Boardwalk.Views.BoardLayout extends Backbone.View
  attributes: ->
    class: 'container'

  template: JST['layouts/board']

  render: ->
    @$el.html @template()
    this
