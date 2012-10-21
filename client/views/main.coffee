root = window

root.Template.main.greeting = ->
  #console.log Session.get('user')
  "Hello #{}"

root.Template.main.events =
  "click .filepickerio": ->
    filepicker.pick(
      {mimetypes:['image/*']},
      (FPFile) ->
        console.log FPFile
      ,
      (FPError) ->
        console.log FPError
      ,
    )

