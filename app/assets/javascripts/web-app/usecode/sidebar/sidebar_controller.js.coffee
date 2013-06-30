class SidebarController extends IuguUI.View
  layout: "sidebar/sidebar"
  secondaryView: true
  className: "iugu-main-sidebar"

  events:
    'click [data-action=dashboard]': 'openDashboard'
    'click [data-action=people]': 'openPeople'
    'click [data-action=logout]': 'submitLogout'

  closeSidebar: ->
    hasSidebarOpened = $(@el).parent '.open'
    hasSidebarOpened.removeClass('open') if hasSidebarOpened

  initialize: ->
    super

    that = @

  submitLogout: (evt) ->
    evt.preventDefault()
    @$("[data-form=logout]").submit()

  openDashboard: (evt) ->
    @closeSidebar()
    evt.preventDefault()
    Backbone.history.navigate app.routes['dashboard#index'], trigger: true

  openPeople: (evt) ->
    @closeSidebar()
    evt.preventDefault()
    Backbone.history.navigate app.routes['people#index'], trigger: true

@SidebarController = SidebarController
