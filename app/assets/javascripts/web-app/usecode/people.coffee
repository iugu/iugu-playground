class PeopleView extends IuguUI.View
  el: '#app-content'
  layout: 'people-view'

  initialize: ->
    _.bindAll @, 'render', 'openRecord'
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

  openRecord: ( context ) ->
    editURL = @options.baseURL + '/edit/' + context.model.get('id')
    Backbone.history.navigate editURL, { trigger: true }

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

class PeopleEdit extends IuguUI.View
  el: '#app-content'
  layout: 'people-edit'

  events:
    'click .save': 'save'
    'click .remove': 'remove'
    'click .removalConfirmation': 'removalConfirmation'

  initialize: ->
    _.bindAll @, 'render', 'save'
    super

  save: (evt) ->
    evt.preventDefault()

    that = @

    @model.save {}
      success: ->
        Backbone.history.navigate 'people', { trigger: true }
        that.unload()

  remove: (evt) ->
    evt.preventDefault()

    that = @

    @model.destroy {}
      success: (model, response) ->
        Backbone.history.navigate 'people', { trigger: true }
        that.unload()

  removalConfirmation: (evt) ->
    evt.preventDefault()

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
    "people"      : "index"
    "people/"     : "index"
    "people/edit/:id" : "edit"
    "people/:page" : "index"

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
