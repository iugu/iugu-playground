class IuguPaginatorComponent extends IuguBaseComponent

  defaults:
    presenterName: "components/iugu-paginator-component"
    numberOfPageButtons: 9
    enableAdditionalButtons: true
    baseURL: ""

  events:
    'click a.page': 'gotoPage'
    'click a.next': ->
      @collection.gotoNext()
      false
    'click a.previous': ->
      @collection.gotoPrevious()
      false

  initialize: ->
    _.bindAll @
    super
    @collection.on('all', @render, this)

  render: ->
    # TODO: Melhorar isto
    $(@el).html @layoutFile() collection: @collection.info(), pageButtons: @pageButtonsToShow(@options.numberOfPageButtons, @collection.information.firstPage, @collection.information.totalPages, @collection.information.currentPage), enableAdditionalButtons: @options.enableAdditionalButtons

    # TODO: Isto tem que sair daqui
    @historyNavigate @collection.currentPage

    @

  gotoPage: (e) ->
    e.preventDefault()
    page = $(e.target).text()
    @collection.goTo(page)

  pageButtonsToShow: (numberOfButtons, firstPage, totalPages, currentPage) ->
    if numberOfButtons > totalPages
      return _.range(1, totalPages + 1)

    surrounding = (numberOfButtons - 3) / 2

    begin = currentPage - Math.floor(surrounding)
    end = currentPage + Math.ceil(surrounding)

    if begin <= firstPage + 1
      offset = firstPage + 1 - begin
      begin += offset
      end += offset
    else if end >= totalPages - 1
      offset = totalPages - end - 1
      begin += offset
      end += offset

    _.range(begin, end + 1)


@IuguPaginatorComponent = IuguPaginatorComponent
