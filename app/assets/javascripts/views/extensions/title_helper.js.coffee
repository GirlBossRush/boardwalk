_.extend Boardwalk,
  setTitle: (prefix) ->
    if prefix == undefined
      title = "Boardwalk.io"
    else
      title = "#{prefix} :: Boardwalk.io"

    document.title = title