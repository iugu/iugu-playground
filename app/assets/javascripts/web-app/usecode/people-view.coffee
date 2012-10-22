class PeopleView extends IuguUI.Base
  el: '#app-content'
  layout: 'people-view'

  initialize: ->
    _.bindAll @, 'render', 'editRecord'
    super

    @paginator = new IuguUI.Paginator
      collection: @collection
      enableAdditionalButtons: false
      baseURL: @options.baseURL
      parent: @
      identifier: 'people-paginator'

    @dataset = new IuguUI.Dataset
      collection: @collection
      baseURL: @options.baseURL
      parent: @
      identifier: 'people-dataset'

    @table = new IuguUI.Table
      collection: @collection
      baseURL: @options.baseURL
      fields:
        id: "#"
        name: "Name"
        age: "Age"
      parent: @
      identifier: 'people-table'

    @navigator = new IuguUI.Navigator
      collection: @collection
      baseURL: @options.baseURL
      parent: @
      identifier: 'people-navigator'

    @on( 'people-table:record:click', @editRecord )
    @on( 'people-table:record:hover', @infoRecord )

  editRecord: ( context ) ->
    debug( 'Editing Record: ' + context.model.get('id') )

  infoRecord: ( context ) ->
    debug( 'Info Record: ' + context.model.get('id') )

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
