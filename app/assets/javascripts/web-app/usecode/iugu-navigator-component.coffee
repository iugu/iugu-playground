class IuguNavigatorComponent extends IuguBaseComponent
  tagName: "div"
  className: "iugu-navigator"

  templatePath: "web-app/presenters/components/iugu-navigator-component"

  events:
    'click a.servernext': 'nextResultPage'
    'click a.serverprevious': 'previousResultPage'
    'change input.gotopage': 'gotoPage'

  initialize: ->
    @bla = 5
    _.bindAll @, 'render', 'gotoPage'
    # @collection.on('all', @render, this)

  render: ->
    $(@el).html JST[@templatePath] collection: @collection.information

    debug 'OKIE DOKIE'

    @$('input.gotopage').focus() if @lastChanged
  
    debug 'Testing'
    debug @lastChanged
    @lastChanged = false

    debug @lastChanged

    @

  nextResultPage: (e) ->
    e.preventDefault
    if @collection.information.currentPage < @collection.information.lastPage
      @collection.requestNextPage()

  previousResultPage: (e) ->
    e.preventDefault
    if @collection.information.currentPage > @collection.information.firstPage
      @collection.requestPreviousPage()

  gotoPage: (e) ->
    e.preventDefault
    page = @$(e.target).val()
    @collection.goTo(page) if page <= @collection.information.lastPage and page >= @collection.information.firstPage
    @lastChanged = true

@IuguNavigatorComponent = IuguNavigatorComponent
