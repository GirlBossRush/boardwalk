class Boardwalk.Views.DefaultLayout extends Backbone.View
  id: 'container'

  events:
    'click #home': "rootURL"
    'click #login': "loginURL"

  template: JST['layouts/default']

  render: ->
    @$el.html @template()
    this

  rootURL: (e) ->
    e.preventDefault()
    Backbone.history.navigate('/', true)

  loginURL: (e) ->
    e.preventDefault()
    Backbone.history.navigate('/login', true)