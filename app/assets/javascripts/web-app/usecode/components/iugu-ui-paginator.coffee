class IuguUI.Paginator extends IuguUI.Base

  layout: "components/iugu-ui-paginator"

  defaults:
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
    super
    @collection.on('all', @render, this)

  render: ->
    return @ unless @collection.info().totalPages
    super

  context: ->
    collection: @collection.info()
    pageButtons: @pageButtonsToShow(@options.numberOfPageButtons, @collection.info().firstPage, @collection.info().totalPages, @collection.info().currentPage)
    enableAdditionalButtons: @options.enableAdditionalButtons

  gotoPage: (e) ->
    e.preventDefault()
    page = $(e.target).text()
    @collection.goTo(page) unless page == '...'

  pageButtonsToShow: (numberOfButtons, firstPage, totalPages, currentPage) ->
    return unless totalPages

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


@IuguUI.Paginator = IuguUI.Paginator
