class PeopleView extends IuguUI.View
  el: '#app-content'
  layout: 'people-view'

  events:
    'click .new-person' : 'newPerson'

  initialize: ->
    _.bindAll @, 'render', 'openRecord', 'enableUndo'
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

    @on( 'people-table:record:click', @openRecord, @ )
    @on( 'people-table:record:mouseenter', @infoINRecord, @ )
    @on( 'people-table:record:mouseleave', @infoOUTRecord, @ )
    @on( 'undo-alert:record:click', @undo )

    @collection.on "undo:success", @refresh
    @collection.on "destroy", @enableUndo
    @collection.on "sync", @enableUndo

  refresh: () ->
    debug 'UNDO OK - O REFRESH soh poderia acontecer em caso de destroy ou create'

  enableUndo: (model) ->

    if @undoAlert
      @undoAlert.close()

    @undoAlert = new IuguUI.Alert
      parent: @
      identifier: 'undo-alert'
      headerText: 'Done!'
      bodyText: 'Do you want to revert it?'
      buttonText: 'UNDO'
      model: model

  undo: (context) ->
    context.model.undo()

  openRecord: ( context ) ->
    editURL = @options.baseURL + '/edit/' + context.model.get('id')
    Backbone.history.navigate editURL, { trigger: true }

  newPerson: (evt) ->
    evt.preventDefault()
    newURL = @options.baseURL + '/new'
    Backbone.history.navigate newURL, { trigger: true }

  infoINRecord: ( context ) ->
    context.$el.css('cursor','pointer')
    context.$el.css('background','#EFEFEF')

  infoOUTRecord: ( context ) ->
    context.$el.css('background','#FFFFFF')

  render: ->
    super

    optionalChilds = {}
    if @undoAlert
      optionalChilds['.alert-placeholder'] = @undoAlert

    @delegateChild(
      _.extend(
        '.collection-pagination'            : @paginator
        '.collection-dataset'               : @table
        '.collection-navigation'            : @navigator
        ,
        optionalChilds
      )
    )

    @
    
@PeopleView = PeopleView

class PeopleNew extends IuguUI.View
  el: '#app-content'
  layout: 'people-new'

  events:
    'click .save': 'save'

  initialize: ->
    _.bindAll @, 'render', 'save', 'goBack'
    super

    @model.on "sync", @goBack, @

  goBack: () ->
    @close()
    window.history.back()

  save: (evt) ->
    evt.preventDefault()
    @model.save wait: true

@PeopleNew = PeopleNew

class PeopleEdit extends IuguUI.View
  el: '#app-content'
  layout: 'people-edit'

  events:
    'click .save': 'save'
    'click .remove': 'remove'

  initialize: ->
    _.bindAll @, 'render', 'save', 'remove', 'goBack'
    super

    @model.on "sync", @goBack, @
    @model.on "destroy", @goBack, @

  goBack: () ->
    @close()
    window.history.back()

  save: (evt) ->
    evt.preventDefault()
    @model.save wait: true

  remove: (evt) ->
    evt.preventDefault()
    @model.destroy wait: true

@PeopleEdit = PeopleEdit

class PeopleRouter extends Backbone.Router
  baseURL: 'people'

  initialize: ->
    _.bindAll @, 'redirectError'
    app.peopleRouter = @
    @

  routes:
    "people"          : "index"
    "people/"         : "index"
    "people/edit/:id" : "edit"
    "people/new"      : "new"
    "people/:page"    : "index"

  initializeView: ->
    unless @view
      @view = new PeopleView( { collection: app.people, baseURL: @baseURL } )
  index: (page = 1) ->
    if page != app.people.currentPage
      app.people.goTo( page )

    @initializeView()
    @view.render()

  redirectError: () ->
    Backbone.history.navigate @baseURL, { trigger: true }

  showEditPage: ( model ) ->
    @editView = new PeopleEdit( { model: model } )
    @editView.render()

  showNewPage: ( model ) ->
    @newView = new PeopleNew( { model: model } )
    @newView.render()
  
  new: ->
    model = new app.Person()

    @showNewPage model

  edit: (id = null) ->
    @initializeView()

    model = null
    model = app.people.get( id )

    if model
      @showEditPage( model )
    else
      model = new app.Person( { id: id } )
      model.fetch( {
        error: @redirectError
        success: ( () ->
          app.people.addModel( model )
          @showEditPage model
        ).bind(@)
      })

    # @editView = new PeopleEdit( { model: model } )

$ ->
  app.people = new app.People
  app.people.paginator_ui.perPage = 10

  app.registerRouter( PeopleRouter )
