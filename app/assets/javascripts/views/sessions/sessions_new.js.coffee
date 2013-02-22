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
    attributes = $form.serializeObject()

    session = new Boardwalk.Models.Session(attributes)

    session.save null,
      wait: true
      success: ->
        userData = session.get('user')
        Backbone.history.navigate("users/#{userData._id}", true)


      error: ->
        $form.find('input:first').focus()
