class PeopleIndex extends IuguUI.View
  layout: 'people-view'
  ###
  emptyCollection:
    imageClass: "peopleEmpty"
    text: "Teste de Texto"
    buttonText: "Adicionar"
    buttonClass: "add-person"
  ###

  events:
    'click .add-person' : 'newPerson'

  initialize: ->
    super

    @configureCustomers()

    @button_toolbar = new IuguUI.Toolbar
      buttons:
        new_person: "+"
        help: "?"
      baseURL: @options.baseURL
      parent: @
      identifier: 'people-button-toolbar'
    
    @filter_age = new IuguUI.SearchFilter
      collection: @collection
      multiSelection: true
      filterName: "age"
      fixedFilters: ["22", "40", "30"]
      baseURL: @options.baseURL
      parent: @
      identifier: 'people-age-filter'

    @filter_gender = new IuguUI.SearchFilter
      collection: @collection
      multiSelection: true
      translateTerms: true
      translationPrefix: "genders"
      filterName: "gender"
      fixedFilters: ["male", "female"]
      baseURL: @options.baseURL
      parent: @
      identifier: 'people-gender-filter'

    @range = new IuguUI.SearchRange
      collection: @collection
      fieldName: "created_at"
      baseURL: @options.baseURL
      parent: @
      identifier: 'people-range'

    @paginator = new IuguUI.Paginator
      enableAdditionalButtons: true
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
      sortableBy: ["id", "age", "gender"]
      fields:
        id: "#"
        name: "Name"
        age: "Age"
        gender: "Gender"
      parent: @
      identifier: 'people-table'

    @navigator = new IuguUI.Navigator
      baseURL: @options.baseURL
      parent: @
      identifier: 'people-navigator'

    @search = new IuguUI.Search
      collection: @collection
      baseURL: @options.baseURL
      parent: @
      identifier: 'people-search'

    IuguUI.Helpers.bindNavigatorToCollection @collection, @navigator, @
    IuguUI.Helpers.bindPaginatorToCollection @collection, @paginator, @

    @on( 'people-table:record:click', @openPerson, @ )
    @on( 'people-button-toolbar:new_person:click', @newPerson, @ )
    @on( 'people-search:search', @clearFilters )

    @enableLoader()
    that = @
    @collection.fetch success: -> that.load()

  clearFilters: ->
    @collection.removeFiltersEndingWith "_filter"

  configureCustomers: ->
    @collection = new app.People

  context: ->
    collection: @collection

  openPerson: ( context ) ->
    Backbone.history.navigate app.routes['people#edit'].replace(':id', context.model.get('id')), { trigger: true }

  newPerson: ( context ) ->
    Backbone.history.navigate app.routes['people#new'], { trigger: true }

  render: ->
    super

    @delegateChild
      '.collection-search'                : @search
      '.collection-pagination'            : @paginator
      '.collection-dataset'               : @table
      '.collection-navigation'            : @navigator
      '.collection-range'                 : @range
      '.collection-filter-age'            : @filter_age
      '.collection-filter-gender'         : @filter_gender
      '.button-toolbar'                   : @button_toolbar

    @
    
@PeopleIndex = PeopleIndex

class PeopleEdit extends IuguUI.HorizontalSplitView
  splitSize: '80%'

  initialize: ->
    super

    @on( 'people-edit-toolbar:back:click', @redirectBack, @ )
    @on( 'people-edit-toolbar:save:click', @save, @ )
    @on( 'people-edit-toolbar:remove:click', @remove, @ )

    if @options.id
      @title = "#{_t "misc.edit_person"} #{@options.id.substr(-8)}"
      @configurePerson()
      @configureComponents()
      @model.fetch()
    else
      @title = _t "misc.new_invoice"
      @model = new window.app.Person
      @configureComponents()
      @load()

  configurePerson: ->
    @model = new window.app.Person { id: @options.id }
    @model.on 'fetch save', @enableLoader, @
    @model.on 'sync', @load, @

  configureComponents: ->
    @buttonToolbar = new IuguUI.Toolbar
      buttons:
        back: "<"
        save: "Save"
        remove: "Remove"
      baseURL: @options.baseURL
      parent: @
      identifier: 'people-edit-toolbar'

    @formView = new IuguUI.View
      model: @model
      baseURL: @options.baseURL
      parent: @
      identifier: 'people-edit-form'
      layout: 'people-edit'
      secondaryView: true

  close: ->
    super

  render: ->
    super

    children = {}
    children[@getBottomViewClass()] = @buttonToolbar
    children[@getTopViewClass()] = @formView

    @delegateChild children

    @

  save: ->
    @model.save null, context: @

@PeopleEdit = PeopleEdit

class PeopleRouter extends Backbone.Router
  baseURL: 'people'

  initialize: ->
    app.routes['people#index'] = 'people'
    app.routes['people#show'] = 'people/:id'
    app.routes['people#new'] = 'people/new'
    app.routes['people#edit'] = 'people/:id/edit'

  routes:
    "people"          : "index"
    "people/"         : "index"
    "people/new"      : "new"
    "people/:id/edit" : "edit"
    "people/:page"    : "index"

  index: ->
    $("#app-content").html (new PeopleIndex).el
    #app.rootWindow.getContent().html (new PeopleIndex).el

  new: ->
    $("#app-content").html (new PeopleEdit).el
    #app.rootWindow.getContent().html (new PeopleEdit).el

  edit: (id) ->
    $("#app-content").html (new PeopleEdit { id: id }).el
    #app.rootWindow.getContent().html (new PeopleEdit { id: id }).el

$ ->
  app.registerRouter( PeopleRouter )
