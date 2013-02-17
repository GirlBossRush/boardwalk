class Boardwalk.Views.DefaultLayout extends Backbone.View
  id: 'container'

  events:
    'click #home': "root_url"

  template: JST['layouts/default']

  render: ->
    @$el.html @template()
    this

  root_url: (e) ->
    e.preventDefault()
    Backbone.history.navigate('/', true)