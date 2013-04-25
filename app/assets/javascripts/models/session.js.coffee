class Boardwalk.Models.Session extends Backbone.Model
  urlRoot: "/api/sessions"

  save: (attributes, options) ->
    initialSuccess = options.success

    _.extend options,
      wait: true
      success: (model) ->
        userData = model.get('user')

        $.cookie 'current_user', {_id: userData._id, username: userData.username},
          path: '/'

        initialSuccess?()
        if options.navigate
          Backbone.history.navigate("users/#{userData.username}", true)

    super(attributes, options)

  destroy: (options) ->
    initialSuccess = options.success

    _.extend options,
      wait: true
      success: ->
        # FIXME: The browser won't seem to remove the cookie until a page reload.
        # $.removeCookie('current_user')
        $.cookie 'current_user', null,
          path: '/'

        initialSuccess?()
        if options.navigate
          Backbone.history.navigate('/login', true)

    super(options)
