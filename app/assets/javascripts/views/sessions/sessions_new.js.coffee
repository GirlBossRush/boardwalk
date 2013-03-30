class Boardwalk.Views.SessionsNew extends Backbone.View

  template: JST['sessions/new']

  events:
    'submit #new-session': 'createSession'

  render: ->
    @$el.html(@template())
    this

  createSession: (e) ->
    e.preventDefault()

    $form = $(e.target)
    attributes = $form.serializeForm()

    session = new Boardwalk.Models.Session(attributes)

    session.save null,
      navigate: true

      error: ->
        $form.find('input[type=password]').val('').focus()
