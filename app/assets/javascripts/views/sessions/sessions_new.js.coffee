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
        $.cookie('user_id', userData._id)
        Backbone.history.navigate("users/#{userData._id}", true)


      error: ->
        $form[0].reset()
        $form.find('input:first').focus()
