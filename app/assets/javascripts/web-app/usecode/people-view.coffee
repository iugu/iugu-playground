class PeopleView extends Backbone.View
  el: "#app-content"
  initialize: ->
    _.bindAll @, 'render'

  render: ->
    @$el.html JST["web-app/presenters/people-view"]
    
    @paginator = new IuguPaginatorComponent(
      el: @$('.collection-pagination')
      collection: @collection
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
    @people = new app.People
    @people.paginator_ui.perPage = 10
    @people

  routes:
    ""      : "index"
    ":page" : "index"

  initializeView: ->
    unless @view
      @view = new PeopleView( { collection: @people } )

  index: (page = 1) ->
    @people.goTo( page )

    @initializeView()
    @view.render()

$ ->
  app.registerRouter( PeopleRouter )
