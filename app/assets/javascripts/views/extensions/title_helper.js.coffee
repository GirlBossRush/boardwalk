_.extend Boardwalk,
  setTitle: (prefix) ->
    if prefix != undefined prefix.length != 0
      title = "#{prefix} :: Boardwalk.io"
    else
      title = "Boardwalk.io"

    document.title = title