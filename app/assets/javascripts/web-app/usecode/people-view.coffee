class PeopleView extends Backbone.View
  el: "#app-content"
  initialize: ->
    _.bindAll @, 'render'
    this.collection.on('add', this.addOne, this)
    this.collection.on('reset', this.addAll, this)
    this.collection.on('all', this.render, this)

  addOne: (person) ->
    view = new PeopleItemView({model: person})
    $('.collection-rows').append(view.render().el)

  addAll: ->
    $('.collection-rows').empty()
    this.collection.each(this.addOne)

  render: ->
    $(@el).html JST["web-app/presenters/people-view"]
    
    @paginator = new IuguPaginator({ el: @$('.collection-pagination'), collection: this.collection})
    @paginator.render()

    @

@PeopleView = PeopleView

class PeopleItemView extends Backbone.View
  tagName: "div"

  initialize: ->
    _.bindAll @, 'render'

  render: ->
    $(@el).html JST["web-app/presenters/people-item-view"] person: this.model

    @

@PeopleItemView = PeopleItemView    

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
