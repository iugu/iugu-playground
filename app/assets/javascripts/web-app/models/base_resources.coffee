window.app.BaseResources = Backbone.Paginator.requestPager.extend

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

  configureFilter: ( param, value ) ->
    @server_api[param] = value
    @trigger 'configured-filter', param

  removeFilter: (param) ->
    delete @server_api[param]
    @trigger "removed-filter:#{param}"

  removeFiltersEndingWith: (param) ->
    self = @
    _.each @server_api, (value, key) ->
      _regex = new RegExp( "#{param}$")
      self.removeFilter(key) if key.match(_regex)

  parse: (response) ->
    @totalRecords = response.totalItems
    @facets = response.facets
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

  disablePagination: () ->
    # 64 Bit Integer Size
    @perPage = 9223372036854775807
