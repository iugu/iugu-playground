MainRouter = Backbone.Router.extend
  initialize: ->
    window.Root = new window.RootView()
    window.Root.render() if window.Root

  clearView: () ->
    if @aView
      $(@aView.el).empty()
      @aView = undefined

$ ->
  app.registerRouter( MainRouter )
