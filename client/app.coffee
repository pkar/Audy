root = global ? window

Audy = Audy || {}

class Audy.AppRouter extends Backbone.Router
  routes:
    "": "index"
    "help": "help"
    "search/:query": "search"
    "*path": "error404"

  initialize: (broker) ->
    @app =
      broker: @broker

  index: ->
    console.log 'index'

  help: ->
    console.log 'help'

  search: (query) ->
    console.log query

  error404: () ->
    document.title = "Error"


Meteor.startup () ->
  broker = _.extend({}, Backbone.Events)
  appRouter = new Audy.AppRouter(broker)
  if not Backbone.history.start({pushState: true})
    appRouter.app.middle.$el.html = new Audy.Views.Error().render().$el
  #console.log $('.filepickerio').trigger 'click'

