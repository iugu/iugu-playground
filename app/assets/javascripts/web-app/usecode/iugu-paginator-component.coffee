class IuguPaginatorComponent extends IuguBaseComponent
  tagName: "div"
  className: "iugu-paginator"

  templatePath: "web-app/presenters/components/iugu-paginator-component"

  events:
    'click a.servernext': 'nextResultPage'
    'click a.serverprevious': 'previousResultPage'
    'click a.serverlast': 'gotoLast'
    'click a.page': 'gotoPage'
    'click a.serverfirst': 'gotoFirst'
    'click a.serverpage': 'gotoPage'
    'click a.serverhowmany': 'changeCount'

  initialize: ->
    _.bindAll @, 'render'
    @collection.on('reset', @render, this)
    @collection.on('change', @render, this)

  render: ->
    $(@el).html JST[@options.templatePath] collection: @collection.info(), pageButtons: @pageButtonsToShow(7, @collection.information.firstPage, @collection.information.totalPages, @collection.information.currentPage)

    @

  nextResultPage: (e) ->
    e.preventDefault
    if @collection.information.currentPage < @collection.information.lastPage
      @collection.requestNextPage()

  previousResultPage: (e) ->
    e.preventDefault
    if @collection.information.currentPage > @collection.information.firstPage
      @collection.requestPreviousPage()

  gotoFirst: (e) ->
    e.preventDefault
    @collection.goTo(@collection.information.firstPage)

  gotoLast: (e) ->
    e.preventDefault
    @collection.goTo(@collection.information.lastPage)

  gotoPage: (e) ->
    e.preventDefault
    page = $(e.target).text()
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
