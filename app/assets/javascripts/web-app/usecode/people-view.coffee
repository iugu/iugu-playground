class PeopleView extends IuguBaseComponent
  el: '#app-content'
  layout: 'people-view'

  initialize: ->
    _.bindAll @, 'render'
    super

    # Os initializers agora ficam aqui
    @paginator = new IuguPaginatorComponent
      collection: @collection
      enableAdditionalButtons: false
      baseURL: @options.baseURL

  render: ->
    super

    # Este novo método permite renderizar uma sub view que nem fazia parte disto, ex: @app.HeaderButtons
    @delegateChild(
      '.collection-pagination'            : @paginator
    )

    @
    
###
  render: ->
    @$el.html @template
    
    @paginator = new IuguPaginatorComponent(
      el: @$('.collection-pagination')
      collection: @collection
      enableAdditionalButtons: false
      baseURL: "people"
    )

    @navigator = new IuguNavigatorComponent(
      el: @$('.collection-navigation')
      collection: @collection
      baseURL: "people"
    )

    @dataset = new IuguDatasetComponent(
      el: @$('.collection-rows')
      collection: @collection
      baseURL: "people"
    )

    @
###

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
