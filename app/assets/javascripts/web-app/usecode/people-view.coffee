class PeopleView extends IuguUI.Base
  el: '#app-content'
  layout: 'people-view'

  initialize: ->
    _.bindAll @, 'render'
    super

    @paginator = new IuguUI.Paginator
      collection: @collection
      enableAdditionalButtons: false
      baseURL: @options.baseURL

    @dataset = new IuguUI.Dataset
      collection: @collection
      baseURL: @options.baseURL

    @table = new IuguUI.Table
      collection: @collection
      baseURL: @options.baseURL
      fields:
        id: "#"
        name: "Name"
        age: "Age"

    @navigator = new IuguUI.Navigator
      collection: @collection
      baseURL: @options.baseURL

  render: ->
    super

    @delegateChild(
      '.collection-pagination'            : @paginator
      '.collection-dataset'               : @table
      '.collection-navigation'            : @navigator
    )

    @
    
@PeopleView = PeopleView

class PeopleRouter extends Backbone.Router
  initialize: ->
    app.peopleRouter = @
    app.people = new app.People
    app.people.paginator_ui.perPage = 10
    @

  routes:
    "people"      : "index"
    "people/"     : "index"
    "people/:page" : "index"

  initializeView: ->
    unless @view
      @view = new PeopleView( { collection: app.people, baseURL: 'people' } )

  index: (page = 1) ->
    app.people.goTo( page )

    @initializeView()
    @view.render()

$ ->
  app.registerRouter( PeopleRouter )
