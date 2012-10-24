class PeopleView extends IuguUI.View
  el: '#app-content'
  layout: 'people-view'

  events:
    'click .new-person' : 'newPerson'

  initialize: ->
    _.bindAll @, 'render', 'openRecord', 'showUndo'
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

    @on( 'people-table:record:click', @openRecord )
    @on( 'people-table:record:mouseenter', @infoINRecord )
    @on( 'people-table:record:mouseleave', @infoOUTRecord )
    @on( 'undo-alert:record:click', @undo )
    @collection.on "undo:success", @refresh
    @collection.on "destroy", @showUndo
    @collection.on "sync", @showUndo

  showUndo: (model) ->
    @undoAlert = new IuguUI.Alert
      parent: @
      identifier: 'undo-alert'
      headerText: 'Are you sure about your previous action?'
      bodyText: 'If you are not sure about your previous action, you could UNDO it'
      buttonText: 'UNDO'

    debug @$("*")

    @$('.alert-placeholder').append @undoAlert.render().el

  undo: (context) ->
    debug context

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

    @delegateChild(
      '.collection-pagination'            : @paginator
      '.collection-dataset'               : @table
      '.collection-navigation'            : @navigator
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
    app.people = new app.People
    app.people.paginator_ui.perPage = 10
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
          @showEditPage model
        ).bind(@)
      })

    # @editView = new PeopleEdit( { model: model } )

$ ->
  app.registerRouter( PeopleRouter )
