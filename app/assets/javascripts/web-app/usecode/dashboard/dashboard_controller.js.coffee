class DashboardController extends IuguUI.View

@DashboardController = DashboardController

class DashboardIndex extends DashboardController
  layout: 'dashboard/index'

  initialize: ->
    super

    @title = _t 'default_actions.dashboard'
    @render()

    @

DashboardRouter = Backbone.Router.extend
  
  initialize: ->
    app.routes['dashboard#index'] = ''

  routes:
    "" : "index"
    "/": "index"

  index: ->
    app.rootWindow.getContent().html (new DashboardIndex).el

$ ->
  app.registerRouter( DashboardRouter )
