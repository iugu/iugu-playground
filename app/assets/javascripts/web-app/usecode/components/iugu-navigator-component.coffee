class IuguNavigatorComponent extends IuguBaseComponent
  defaults:
    presenterName: "iugu-navigator-component"
    baseURL: ""

  events:
    'click a.next': ->
      @collection.gotoNext()
      false
    'click a.previous': ->
      @collection.gotoPrevious()
      false
    'change input.page': 'changedPage'

  changedPage: (e) ->
    e.preventDefault()
    old_page = @collection.currentPage
    page = $(e.target).val()
    page = old_page if page == ''
    if @collection.information.lastPage+1 > page
      @collection.goTo( page )
      @lastChanged = true
      true
    else
      $(e.target).val( old_page )
      $(e.target).select()
      false
      

  initialize: ->
    _.bindAll @
    super
    @collection.on('all', @render, this)

  render: ->
    $(@el).html JST[@presenterFile()] collection: @collection.information

    @$('input.page').focus() if @lastChanged
    @lastChanged = false

    @historyNavigate @collection.currentPage

    @

@IuguNavigatorComponent = IuguNavigatorComponent