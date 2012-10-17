class PeopleView extends Backbone.View
  el: "#app-content"
  initialize: ->
    _.bindAll @, 'render'

  render: ->
    @$el.html JST["web-app/presenters/people-view"]
    
    @paginator = new IuguPaginatorComponent(
      el: @$('.collection-pagination')
      collection: @collection
      enableAdditionalButtons: false
    )

    @navigator = new IuguNavigatorComponent(
      el: @$('.collection-navigation')
      collection: @collection
    )

    @dataset = new IuguDatasetComponent(
      el: @$('.collection-rows')
      collection: @collection
    )

    # @paginator.render()
    # @dataset.render()

    @

@PeopleView = PeopleView

class PeopleRouter extends Backbone.Router
  initialize: ->
    # TODO: Precisamos de um lugar melhor para acessar coleções existentes
    window.app._collections = {}
    window.app._collections.People = new app.People
    window.app._collections.People.paginator_ui.perPage = 10
    debug window.app._collections
    @

  routes:
    ""      : "index"
    ":page" : "index"

  initializeView: ->
    unless @view
      @view = new PeopleView( { collection: window.app._collections.People } )

  index: (page = 1) ->
    app._collections.People.goTo( page )

    @initializeView()
    @view.render()

$ ->
  app.registerRouter( PeopleRouter )
