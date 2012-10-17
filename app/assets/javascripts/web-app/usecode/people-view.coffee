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
      baseURL: "people"
    )

    @navigator = new IuguNavigatorComponent(
      el: @$('.collection-navigation')
      collection: @collection
      baseURL: "people"
    )

    ###
    @table = new IuguTableComponent(
      el: @$('.collection-rows')
      collection: @collection
      baseURL: "people"
      fields:
        id: "#"
        name: "Name"
        age: "Age"
    )
    ###
    
    @dataset = new IuguDatasetComponent(
      el: @$('.collection-rows')
      collection: @collection
      baseURL: "people"
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
      @view = new PeopleView( { collection: app.people } )

  index: (page = 1) ->
    app.people.goTo( page )

    @initializeView()
    @view.render()

$ ->
  app.registerRouter( PeopleRouter )
