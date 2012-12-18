window.app.BasePaginatedResource = Backbone.Paginator.requestPager.extend

  paginator_ui:
    firstPage: 1
    currentPage: 1
    perPage: 30

  server_api:
    'limit': ->
      return @perPage

    'start': ->
      return (@currentPage - 1) * @perPage

    'api_token': ->
      return api_token

  parse: (response) ->
    @totalRecords = response.totalItems
    @totalPages = Math.ceil(@totalRecords / @perPage)
    return response.items

  buildChangedPageEventOptions: ->
    success: ( ( collection, response ) ->
      @trigger 'changed-page:success'
    ).bind @
    error: ( ( collection, response ) ->
      @trigger 'changed-page:error'
    ).bind @

  gotoFirst: ->
    @goTo @information.firstPage, @buildChangedPageEventOptions()

  gotoLast: ->
    @goTo @information.lastPage, @buildChangedPageEventOptions()

  gotoPage: ( page ) ->
    @goTo page, @buildChangedPageEventOptions()

  gotoNext: ->
    if @information.currentPage < @information.lastPage
      @requestNextPage @buildChangedPageEventOptions()

  gotoPrevious: ->
    if @information.currentPage > 1
      @requestPreviousPage @buildChangedPageEventOptions()
