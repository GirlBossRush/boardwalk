#
# * serializeForm
# * https://github.com/danheberden/serializeForm
# *
# * Copyright (c) 2012 Dan Heberden
# * Licensed under the MIT, GPL licenses.
#
(($) ->
  $.fn.serializeForm = ->

    # don't do anything if we didn't get any elements
    return false  if @length < 1
    data = {}
    lookup = data #current reference of data
    selector = ":input[type!=\"checkbox\"][type!=\"radio\"], input:checked"
    parse = ->

      # data[a][b] becomes [ data, a, b ]
      named = @name.replace(/\[([^\]]+)?\]/g, ",$1").split(",")
      cap = named.length - 1
      $el = $(this)

      # Ensure that only elements with valid `name` properties will be serialized
      if named[0]
        i = 0

        while i < cap

          # move down the tree - create objects or array if necessary
          lookup = lookup[named[i]] = lookup[named[i]] or ((if named[i + 1] is "" then [] else {}))
          i++

        # at the end, push or assign the value
        if lookup.length isnt `undefined`
          lookup.push $el.val()
        else
          lookup[named[cap]] = $el.val()

        # assign the reference back to root
        lookup = data


    # first, check for elements passed into this function
    @filter(selector).each parse

    # then parse possible child elements
    @find(selector).each parse

    # return data
    data
) jQuery