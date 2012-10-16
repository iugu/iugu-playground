class PeopleView extends Backbone.View
  el: "#app-content"
  initialize: ->
    _.bindAll @, 'render'

  render: ->
    $(@el).html JST["web-app/presenters/people-view"]
    
    @paginator = new IuguPaginator({ el: @$('.collection-pagination'), collection: this.collection})
    @paginator.render

    @

@PeopleView = PeopleView

class PeopleRouter extends Backbone.Router
  initialize: ->
    @people = new app.People

  routes:
    ""      : "index"
    ":page" : "index"

  initializeView: ->
    unless @view
      @view = new PeopleView( { collection: @people } )

  index: (page = 0) ->
    @people.goTo( page )

    @initializeView()
    @view.render()

$ ->
  app.registerRouter( PeopleRouter )
