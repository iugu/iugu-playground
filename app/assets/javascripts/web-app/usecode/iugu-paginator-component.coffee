class IuguPaginatorComponent extends IuguBaseComponent
  presenterName: "iugu-paginator-component"
  numberOfPageButtons: 9
  enableAdditionalButtons: true

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
    @collection.on('all', @render, this)

  render: ->
    $(@el).html JST[@presenterFile()] collection: @collection.info(), pageButtons: @pageButtonsToShow(@numberOfPageButtons, @collection.information.firstPage, @collection.information.totalPages, @collection.information.currentPage)

    @

  gotoPage: (e) ->
    e.preventDefault
    page = $(e.target).text()
    debug 'ok'
    @collection.goTo(page)

  changeCount: (e) ->
    e.preventDefault
    per = $(e.target).text()
    @collection.howManyPer(per)

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
