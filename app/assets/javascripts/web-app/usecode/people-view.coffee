PeopleView = Backbone.View.extend
  el: "#app-content"
  initialize: ->
    _.bindAll @, 'render'

  render: ->
    $(@el).html JST["web-app/presenters/people-view"] totalRecords: 500

    debug 'Checking Collection URL: ' + @collection.paginator_core.url

    @

@PeopleView = PeopleView

PeopleRouter = Backbone.Router.extend
  initialize: ->
    @people = new app.People
  routes:
    ""        : "index"
    ":page"       : "index"

  initializeView: ->
    unless @view
      @view = new PeopleView( { collection: @people } )

  index: (page = 0) ->
    debug 'Requesting Page: ' + page
    @people.goTo( page )

    @initializeView()
    @view.render()

$ ->
  app.registerRouter( PeopleRouter )
