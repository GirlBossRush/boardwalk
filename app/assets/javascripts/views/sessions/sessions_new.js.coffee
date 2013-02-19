class Boardwalk.Views.SessionsNew extends Backbone.View

  template: JST['sessions/new']

  events:
    'submit #new-session': 'createSession'

  render: ->
    $(@el).html(@template())
    this

  createSession: (e) ->
    e.preventDefault()

    $form = $(e.target)
    attributes = $form.serializeObject()

    @session = new Boardwalk.Models.Session(attributes)

    @session.save null,
      wait: true
      success: (model) ->
        $form[0].reset()

      error: ->
        $form.find('input:first').focus()